#!/bin/bash

set -e

image_name="my-dev-env"
container_name="my-dev-env"
user_name="$(whoami)"
user_id="$(id -u)"
group_id="$(id -g)"
home_inside="/home/$user_name"
timezone="$(cat /etc/timezone)"

if [[ "$(docker images -q $image_name 2> /dev/null)" == "" ]]; then
  docker build \
  --build-arg USER_NAME="$user_name" \
  --build-arg USER_ID="$user_id" \
  --build-arg DEBIAN_FRONTEND="noninteractive" \
  --build-arg TZ="$timezone" \
  -t "$image_name" .
fi

if [[ "$(docker ps -q -f status=running -f name=$container_name)" == "" ]]; then
  docker run -it --rm \
  --network=host \
  --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
  -e DISPLAY="unix$DISPLAY" \
  --user "$user_id:$group_id" \
  --name "$container_name" \
  --mount type=volume,source="dev-env-home",target="$home_inside/" \
  --mount type=bind,source="$HOME/.gitconfig",target="$home_inside/.gitconfig" \
  --mount type=bind,source="$HOME/.git-credentials",target="$home_inside/.git-credentials" \
  --mount type=bind,source="$HOME/.zshrc",target="$home_inside/.zshrc" \
  --mount type=bind,source="$HOME/.zsh",target="$home_inside/.zsh" \
  --mount type=bind,source="$HOME/.zsh_history",target="$home_inside/.zsh_history" \
  --mount type=bind,source="$HOME/.spacemacs",target="$home_inside/.spacemacs" \
  "$image_name" \
  zsh
else
  docker exec -it "$container_name" zsh
fi
