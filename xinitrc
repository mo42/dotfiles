#!/bin/zsh
xrdb ~/.Xresources &
redshift-gtk -l 52:13 &
if [[ "OS_RELEASE_ID" == "fedora" ]]; then
  sh /etc/X11/xinit/xinitrc &
  xsetroot -solid "#333333" &
fi
xmodmap ~/.Xmodmap
exec i3
