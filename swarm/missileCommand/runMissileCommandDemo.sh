#!/bin/bash

#
# Demo file to show interacting with swarm by deploying
# missile command to the swarm
#
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

#
# PREREQUITES
# Assumes manager and all worker nodes are already part of the swarm.
#

# clean up in case network or stack already running
docker stop chrome
docker stack rm missile-command
clear

# Show compose
COMMAND='vim command-compose.yml'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Start swarm
COMMAND='docker stack deploy -c command-compose.yml missile-command'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# show how many are running/requested
COMMAND='docker service ls'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# scaler
COMMAND='java Scaler'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
cd ./scaler; ./runScaler.sh
echo
pause

# Stop swarm
COMMAND='docker stack rm missile-command'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause




