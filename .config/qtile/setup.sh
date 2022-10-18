#!/usr/bin/env bash

autorandr --change

lxqt-session &
mate-power-manager &
nitrogen --restore &
dunst &

pnmixer &
