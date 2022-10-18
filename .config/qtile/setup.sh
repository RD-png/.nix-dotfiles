#!/usr/bin/env bash

autorandr --change

lxsession &
mate-power-manager &
nitrogen --restore &
dunst &

pnmixer &
