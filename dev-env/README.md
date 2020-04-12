# Dev-env 

Docker image for my personal development environment:

* JDK
* Javascript, Node, NPM
* Clojure(script)
* Zsh with pure-prompt
* Git (shared configuration with host)
* Spacemacs

You have to be running Xorg server on your host for this to work.

## Usage

Create a symbolic link for running the container from anywhere:

```bash
sudo ln -s "$(pwd)/dev-env.sh" /usr/local/bin/dev-env.sh
```

The linked script makes sure that required files exist on the host, the
image is built and and only a single container is ran at the same time.

After linking the script it can be run with:

```bash
dev-env.sh
```
