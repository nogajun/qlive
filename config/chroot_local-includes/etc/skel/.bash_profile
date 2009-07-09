#!/bin/bash
#startx

if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ] 
then
	startx -- :1
else
        echo "-- Not starting."
        exit 1
fi

# shutdown
sudo sh -c "/sbin/shutdown -h now"
