FROM ubuntu:18.04
ARG uname=wayne

RUN apt update
RUN apt install -y sudo git vim

COPY etcpasswd /etc/passwd
COPY etcgroup /etc/group
COPY etcshadow /etc/shadow

RUN mkdir /home/${uname}
RUN chown ${uname}:${uname} /home/${uname}

COPY entrypoint.sh .
COPY setup_ssh_keys.sh .
COPY git-clone.sh /home/${uname}
RUN chown ${uname}:${uname} /home/${uname}/git-clone.sh

#RUN chmod +x setup_ssh_keys.sh
USER ${uname}
ENTRYPOINT bash entrypoint.sh
