#!/usr/bin/env bash

if [[ "$(uname -n)" = "nixos-desktop" ]]
then
    xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144.00
fi

if [[ "$(uname -n)" = "nixos-work" ]]
then
    xrandr --output VGA-1 --mode 1920x1080
    xrandr --output DP-1 --mode 1920x1080 --left-of VGA-1
fi
   
feh --bg-scale ~/.config/qtile/photo-1510839154674-905169657821.jpeg
