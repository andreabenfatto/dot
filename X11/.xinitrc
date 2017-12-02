#!/bin/sh
#
# 
if [ -d /etc/X11/xinit/xinitrc.d ]; then
   for f in /etc/X11/xinit/xinitrc.d/*; do
       [ -x "$f" ] && . "$f"
   done
   unset f
fi

# Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

## Rotate left the display
#xrandr --output HDMI1 --auto --rotate left &

## Background Color
xsetroot -solid "#333333" &
feh --bg-fill  ~/pictures/rhino.jpg &
# Start redshift
redshift &

## starts the i3 window manager
exec i3
