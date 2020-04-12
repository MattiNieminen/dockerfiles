FROM ubuntu:19.10

ARG USER_NAME
ARG USER_ID

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
git \
openjdk-11-jdk \
firefox && \
# Install Clojure
curl -O https://download.clojure.org/install/linux-install-1.10.1.536.sh && \
chmod +x linux-install-1.10.1.536.sh && \
./linux-install-1.10.1.536.sh && \
rm linux-install-1.10.1.536.sh && \
# Add a user
useradd -m -s /bin/bash -u $USER_ID -G sudo $USER_NAME

# Switch to created user
#USER $USER_NAME
