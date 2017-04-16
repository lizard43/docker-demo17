#!/bin/bash

#
# Demo file to show basic docker commands.  It will start an nginx image in a
# container and will show how to stop and remove it.
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

# remove the demo nginx container if there
docker stop demo_nginx
docker rm demo_nginx
clear

# Show fake an nginx pull since not connected online
COMMAND='docker pull nginx'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
echo Using default tag: latest
echo latest: Pulling from library/nginx
echo 6d827a3ef358: Pull complete
echo f8f2e0556751: Pull complete
echo 5c9972dca3fd: Pull complete
echo 451b9524cb06: Pull complete
echo Digest: sha256:e6693c20186f837fc393390135d8a598a96a833917917789d63766cab6c59582
echo Status: Downloaded newer image for nginx:latest
echo
pause

# Show docker images
COMMAND='docker images'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Start nginx
COMMAND='docker run -d --name demo_nginx -p 80:80 nginx'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Display the nginx running container
COMMAND='docker ps'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Stop the nginx container
COMMAND='docker stop demo_nginx'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Show that no containers are running
COMMAND='docker ps'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Show that no containers are running
COMMAND='docker ps -a'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Show that no containers are running
COMMAND='docker rm demo_nginx'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Show that no containers exist
COMMAND='docker ps -a'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# Simulate docker remove image
COMMAND='docker rmi nginx'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
echo Untagged: nginx:latest
echo Untagged: nginx@sha256:e6693c20186f837fc393390135d8a598a96a833917917789d63766cab6c59582
echo Deleted: sha256:5766334bdaa0bc37f1f0c02cb94c351f9b076bcffa042d6ce811b0fd9bc31f3b
echo Deleted: sha256:1fcf2d3addf02c3b6add24c7b0993038f7e3eee616b10e671e25440e03bc7697
echo Deleted: sha256:51c56cdbb9306c4d6f2da2b780924f3b926bd13d15a4f6693a5175690e288436
echo Deleted: sha256:ec9a826666cfa5df0471f716145da63294019c09a5f2e31613122b57df8f7ce0
echo Deleted: sha256:5d6cbe0dbcf9a675e86aa0fbedf7ed8756d557c7468d6a7c64bde7fa9e029636
echo
pause

