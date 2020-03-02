#!/usr/bin/env bash
setxkbmap -option caps:ctrl_modifier
xmodmap -e "keycode 112 = semicolon colon"
