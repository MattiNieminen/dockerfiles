# Dev-env 

Docker image for my personal development environment:

* Git (shared configuration with host)
* Zsh (shared configuration with host)
* JDK, Maven
* Javascript, Node, NPM
* Clojure(script)
* Spacemacs (shared configuration with host)
* Various utilities

The home directory of the user inside the container is mounted
as a named volume, meaning that files in home directory are
saved even between image builds and container restarts.

You have to be running Xorg server on your host for this to work.

This image can be also used as a parent image for more specific
development enviroments.

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

### Child images

See ```dev-env.sh --help``` for instructions how to select build directory
and give a distinct name for the image and container. Below is an example
Dockerfile where JDK 8 is used and a command how to build a derived image:

Dockerfile:

```
FROM my-dev-env:latest

##
## Root phase
##
USER root
WORKDIR /
# Java 8
apt-get install -y --no-install-recommends openjdk-8-jdk && \
update-java-alternatives -s java-1.8.0-openjdk-amd64

#
# User phase
#
USER $USER_NAME
WORKDIR /home/$USER_NAME

```

First build the parent image by running ```dev-env.sh``` normally.
Then build the child image with the command below:

```bash
dev-env.sh --build [PATH-TO-DIR-WITH-ABOVE-DOCKERFILE] --name jdk8-dev-env
```
