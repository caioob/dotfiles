#!/bin/sh
PID_KBD=$(ps -eo pid,comm | awk '/wvkbd-deskintl$/ {print $1}')
if [ -z "${PID_KBD}" ]
then
    /usr/bin/wvkbd-deskintl &
    return 0
else
    kill -34 ${PID_KBD}
fi
