### Instructions

This image and container give the user the ability to create and use SSH keys as a client. The instructions below also show how to add the SSH key that is created by this container to your GitHub's collection of SSH keys.

To modify this for your needs, you need to make a couple of changes. First you need to change the user that will be used in the container. To do this, you can __either__

1. Open `Dockerfile` and change `ARG uname=wayne` to `ARG uname=yourusername`, where `yourusername` is your username on your host machine.
2. Open `bar.sh` and add ` --build-arg uname=yourusername` to line 15 in the `docker build` command.

You can also open `entrypoint.sh` and modify the values for `SSH_PASSPHRASE` and `SSH_COMMENT` if you like.

To build the image and run the container, run this command:

```bash
bash bar.sh
```

When this completes running, you should be at the command line inside the container. And you should be in the home directory (i.e. `$HOME` should be `/home/yourusername-on-host`). Your private key `id_rsa` and public key `id_rsa.pub` should be in the folder `$HOME/.ssh`.

### Add to your GitHub account

From that point, you can run this

```bash
vi .ssh/id_rsa.pub
```

Then highlight all of the content in that file and press `ctrl-shift-c`. Then follow the instructions in step 2 from [this page](https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account). Now you should be able to interact with your GitHub account from this container as you normally would from your host. For instance, the file `git-clone.sh` has an example that you can modify.
