#!/bin/zsh
xrdb ~/.Xresources &
xmodmap ~/.Xmodmap &
if [[ "$OS_RELEASE_ID" == "fedora" ]]; then
  setxkbmap us
fi
redshift-gtk -l 52:13 &
exec i3
