FROM ubuntu:19.10

ARG USER_NAME
ARG USER_ID
ARG GROUP_ID

#Update packages
RUN apt-get update && \
apt-get upgrade -y --no-install-recommends && \
# Install packages from repositories
apt-get install -y --no-install-recommends firefox && \
# Add user
useradd -m -s /bin/bash -u $USER_ID $USER_NAME
