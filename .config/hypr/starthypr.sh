#!/usr/bin/env bash

# Wallpaper
swww init &

# walpaper
swww img ~/.wallpapers/tatami-16_9.png &

# NetworkManager applet
nm-applet --indicator &

# Waybar
waybar &

# Notification manager
dunst &

discord
