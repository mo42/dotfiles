#!/bin/sh

IMAGE=$(mktemp --suffix=.png)
import -window root $IMAGE
convert $IMAGE -filter Gaussian -resize 20% -define filter:sigma=2.5 -resize 500% $IMAGE
i3lock -i "$IMAGE"
