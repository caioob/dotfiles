#!/usr/bin/env sh

## Add this to your wm startup file.

#multi-monitor

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar -c ~/.config/polybar/polybar-1/config.ini main &
