#!/bin/bash

set -e

image_name="my-dev-env"
container_name="my-dev-env"
user_name="$(whoami)"
user_id="$(id -u)"
group_id="$(id -g)"

if [[ "$(docker images -q $image_name 2> /dev/null)" == "" ]]; then
  docker build \
  --build-arg USER_NAME="$user_name" \
  --build-arg USER_ID="$user_id" \
  -t "$image_name" .
fi

docker run -it --rm \
--network=host \
--mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
-e DISPLAY="unix$DISPLAY" \
--user "$user_id:$group_id" \
--name "$container_name" \
"$image_name" \
bash