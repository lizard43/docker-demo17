#!/bin/bash

#
# Demo file to show a docker compose example
#
# This script is intensed to be used as part of the demo.
# It echos a command line as if it was being typed live and then executes the line.
# It then pauses and waits for a keypress before continuing.
#
# To do this magic, it requires the 'randtype' package to be installed:
#    sudu apt-get install randtype
#
#
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
#

#    vvvv vvvv-- the code from above
HL='\033[0;31m' # Highlight
NC='\033[0m' # No Color

# util function to pause between commands, wait for a keystroke
pause(){
read -n1 -rsp $'$ '
}

# remove any dangling docker volumes so that vote count is not incorrect
docker volume rm $(docker volume ls -f dangling=true -q)
clear

# Docker compose up
COMMAND='docker-compose up -d'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Docker compose down
COMMAND='docker-compose down'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause
