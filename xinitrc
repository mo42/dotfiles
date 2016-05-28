#!/bin/zsh
while true
do
  if [ -f "/sys/class/power_supply/AC/online" ] && [ `cat /sys/class/power_supply/AC/online` -eq "1" ]; then
    BAR_POWER="AC"
  elif [ -f "/sys/class/power_supply/BAT0/capacity" ]; then
    BAR_POWER=`cat /sys/class/power_supply/BAT0/capacity`
  else
    BAR_POWER="AC"
  fi
  BAR_TODO="`head -n 1 todo.txt`"
  BAR_POWER="Power: [$BAR_POWER]"
  BAR_CLOCK=`date +'%Y-%m-%d %H:%M'`
  BAR_REAL_NAME="`getent passwd $USER | cut -d ':' -f 5 | cut -d ',' -f 1`"
  BAR_USER="$USER@`hostname`"
  xsetroot -name "Todo: $BAR_TODO | $BAR_POWER | $BAR_CLOCK | $BAR_REAL_NAME | $BAR_USER"
  sleep 1m
done &
unclutter -idle 8 &
setxkbmap us
xbindkeys
xinput set-button-map 11 1 2 3 5 4
xinput set-button-map 10 1 2 3 5 4 6 7 8 9 10 11 12
xmodmap ~/.Xmodmap
exec dwm
