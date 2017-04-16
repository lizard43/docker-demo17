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
docker network rm command-net
clear

# show existing networks
COMMAND='docker network ls'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Create an attachable network so we can later join containers to network (mostly for debug)
COMMAND='docker network create --driver=overlay --attachable command-net'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# show new network
COMMAND='docker network ls'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# inspect new network
COMMAND='docker network inspect command-net'
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

# start browser to see the show
COMMAND='./chrome/runChrome.sh'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# inspect new network to show cntainers
COMMAND='docker network inspect command-net'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause











