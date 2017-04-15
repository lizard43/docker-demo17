#!/bin/bash

# This starts the sparkles python script

sudo cat /dev/null > /tmp/sparkles.log

sudo date >> /tmp/sparkles.log 

# do while loop until wlan is ready. Then run sparkles

# while ! /sbin/ifconfig | grep 'docker0' 
# do
#    echo sleeping for docker
#    sleep 1
# done

# while ! /sbin/ifconfig wlan0 | grep 'inet addr:[0-9]' 
# do
#    echo sleeping for wlan
#    sleep 1
# done

# sudo /sbin/ifconfig >> /tmp/sparkles.log 2>&1

sudo /home/pirate/sparkles/sparklesNative.py >> /tmp/sparkles.log 2>&1 &

sudo date >> /tmp/sparkles.log 
