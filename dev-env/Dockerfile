FROM ubuntu:20.04

ARG USER_NAME
ONBUILD ARG USER_NAME

ARG USER_ID
ONBUILD ARG USER_ID

ARG DEBIAN_FRONTEND
ONBUILD ARG DEBIAN_FRONTEND
ENV DEBIAN_FRONTEND=$DEBIAN_FRONTEND

ARG TZ
ONBUILD ARG TZ
ENV TZ=$TZ

##
## Root phase
##

# Update packages
RUN apt-get update && \
apt-get upgrade -y --no-install-recommends && \
# Install packages from the repositories
apt-get install -y --no-install-recommends \
sudo \
curl \
rlwrap \
gnupg \
fonts-ubuntu \
git \
openjdk-11-jdk \
maven \
leiningen \
zsh \
emacs \
cloc && \
# Google Chrome
curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
apt install -y ./google-chrome-stable_current_amd64.deb && \
# Install Clojure
curl -O https://download.clojure.org/install/linux-install-1.10.1.536.sh && \
chmod +x linux-install-1.10.1.536.sh && \
./linux-install-1.10.1.536.sh && \
rm linux-install-1.10.1.536.sh && \
# Node
curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
sudo apt-get install -y nodejs && \
# Add a user
useradd -m -s /bin/bash -u $USER_ID -G sudo $USER_NAME

#
# User phase
#
USER $USER_NAME
WORKDIR /home/$USER_NAME
# Spacemacs
RUN git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d
