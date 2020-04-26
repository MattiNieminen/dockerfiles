# Dev-env 

Docker image for my personal development environment:

* Git (shared configuration with host)
* Zsh (shared configuration with host)
* JDK
* Javascript, Node, NPM
* Clojure(script)
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
