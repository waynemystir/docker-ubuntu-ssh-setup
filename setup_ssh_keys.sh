#! /bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters. We got $# parameters and expected 2."
    exit -1
fi

PASSWD=$1
COMMENT=$2

echo "The passphrase is '${PASSWD}' and the comment is '${COMMENT}'."

cd $HOME
echo "Current directory is ${PWD}"
echo "User is $(whoami)"

ssh-keygen -N "$PASSWD" -f "${HOME}/.ssh/id_rsa" -t rsa -b 4096 -C "${COMMENT}"
eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/id_rsa

# We don't want to walk through an interactive
# session for ssh-add. Instead we use 'install'
# and 'SSH_ASKPASS' as prescribed here:
#
# https://stackoverflow.com/a/42304508/1884520

# the following is just a one-liner method of making an executable
# one-line script echoing the password to STDOUT
#
install -vm700 <(echo "echo $PASSWD") "$PWD/ps.sh"

# then the magic happens. NOTE: your DISPLAY variable should be set
# for this method to work (see ssh-add(1))
#
[[ -z "$DISPLAY" ]] && export DISPLAY=:0
< ~/.ssh/id_rsa SSH_ASKPASS="$PWD/ps.sh" ssh-add - && shred -n3 -uz  $PWD/ps.sh

# This keeps the container running and iteractive
# You can comment this out if you're not running
# this in a container
#
bash
