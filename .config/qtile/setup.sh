#!/usr/bin/env bash

autorandr --change

lxsession &
lxqt-powermanagement &
nitrogen --restore &
dunst &

pnmixer &
