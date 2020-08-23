#!/bin/bash

set -e

name="my-dev-env"
build_dir=.
delete_image="false"
user_name="$(whoami)"
user_id="$(id -u)"
group_id="$(id -g)"
home_inside="/home/$user_name"
timezone="$(cat /etc/timezone)"

die() {
  echo "$1" >&2
  exit 1
}

help() {
  cat << EOF
Usage: ${0##*/} [--build [DIRECTORY]] [--name IMAGE_NAME]
Runs a Docker container for my personal development environment.

Also builds the image if an image with the same name does not already exist.
Option --build can be used to specify the build directory and force rebuilding.
See README.md for additional information.

  --help                 display this help and exit.
  --build [DIRECTORY]    build the image inside DIRECTORY (defaults to current dir).
                         Rebuilds if the image with the same name already exists.
  --name IMAGE_NAME      override the name for the image, container and volume.
EOF
}

deleteImage() {
  if [[ "$(docker images -q $name 2> /dev/null)" != "" ]]; then
    docker rmi "$name"
  fi
}

buildImage() {
  if [[ "$(docker images -q $name 2> /dev/null)" == "" ]]; then
    docker build \
    --build-arg USER_NAME="$user_name" \
    --build-arg USER_ID="$user_id" \
    --build-arg DEBIAN_FRONTEND="noninteractive" \
    --build-arg TZ="$timezone" \
    -t "$name" "$build_dir"
  fi
}

runContainer() {
  if [[ "$(docker ps -q -f status=running -f name=$name)" == "" ]]; then
    docker run -it --rm \
    --privileged \
    --network=host \
    --mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
    -e DISPLAY="unix$DISPLAY" \
    --user "$user_id:$group_id" \
    --name "$name" \
    --mount type=volume,source="$name",target="$home_inside/" \
    --mount type=bind,source="$HOME/.gitconfig",target="$home_inside/.gitconfig" \
    --mount type=bind,source="$HOME/.git-credentials",target="$home_inside/.git-credentials" \
    --mount type=bind,source="$HOME/.zshrc",target="$home_inside/.zshrc" \
    --mount type=bind,source="$HOME/.zsh",target="$home_inside/.zsh" \
    --mount type=bind,source="$HOME/.zsh_history",target="$home_inside/.zsh_history" \
    --mount type=bind,source="$HOME/.spacemacs",target="$home_inside/.spacemacs" \
    --mount type=bind,source="$HOME/workspace",target="$home_inside/workspace" \
    "$name" \
    zsh
  else
    docker exec -it "$name" zsh
  fi
}

while :; do
  case $1 in
    --help)
      help
      exit
      ;;
    --build)
      if [ "$2" ]; then
        build_dir="$2"
        delete_image="true"
        shift
      else
        die "ERROR: --build-dir requires a non-empty option argument."
      fi
      ;;
    --name)
      if [ "$2" ]; then
        name="$2"
        shift
      else
        die "ERROR: --name requires a non-empty option argument."
      fi
      ;;
    -?*)
      die "ERROR: Unknown option: $1."
      ;;
    *)
      break
  esac
  shift
done

if [[ "$delete_image" == "true" ]]; then
  deleteImage
fi

buildImage
runContainer
