#!/usr/bin/env bash

autorandr --change

lxsession &
run xfce4-power-manager &
pa-applet &
nitrogen --restore &
dunst &
