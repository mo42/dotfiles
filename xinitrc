#!/bin/zsh

xrdb -merge ~/.Xdefaults &
redshift-gtk -l 52:13 &
xmodmap ~/.Xmodmap
xrandr --output eDP-1 --primary --mode 1600x900
if [[ $OS_RELEASE_ID == "fedora" ]]; then
  sh /etc/X11/xinit/xinitrc &
  xsetroot -solid "#333333" &
fi
exec i3
