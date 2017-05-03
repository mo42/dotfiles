#!/bin/zsh
if xrandr | grep "VGA1 connected"; then
  xrandr --output VGA1 --auto --right-of LVDS1
fi
exec i3
