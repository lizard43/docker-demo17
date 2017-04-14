#!/bin/bash

#
# This installs the Unicorn and sparkles script dependancies
#

sudo apt-get -qy remove python-pip
sudo easy_install pip


sudo apt-get -q update
sudo apt-get -qy install python-dev python-pip gcc make
sudo pip install rpi-ws281x
sudo pip install UnicornHat

sudo easy_install web.py
sudo easy_install netifaces

#sudo apt-get -qy remove python-dev gcc make
#sudo rm -rf /var/lib/apt/lists/*
sudo apt-get -qy clean all


