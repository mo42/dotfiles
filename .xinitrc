#!/bin/zsh

xrdb -merge ~/.Xdefaults &
redshift-gtk -l 52:13 &
xmodmap ~/.Xmodmap &
if [[ $OS_RELEASE_ID == "fedora" ]]; then
  xrandr --output eDP-1 --right-of DP-2 --mode 1600x900 &
  sh /etc/X11/xinit/xinitrc &
fi
/home2/mo/.fehbg &
exec i3
