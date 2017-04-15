#!/bin/bash

#
# Demo file to show interacting with swarm by show status, creating a service,
# scaling it and then stopping service
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

# stop docker visualizer if already running
docker stop swarm-viz
docker swarm leave --force
clear

# Start swarm visualizer
COMMAND='docker run -dt --rm -p 8080:8080 --name swarm-viz -v /var/run/docker.sock:/var/run/docker.sock  manomarks/visualizer'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
./runSwarmVisualizer.sh
echo
pause
 
# Init swarm manager
COMMAND='docker swarm init'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

#
# Using the mouse, copy the output with join-token resulting 
# from the above swarm init command
#
 
# Show that we have 1 node that is a manager
COMMAND='docker node ls'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

#
# Using mouse, paste the join-token comman to the other nodes that will be
# part of the swarm.
#
 
# Show that we have 5 nodes. 1 manager, 4 workers
COMMAND='docker node ls'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# if you later want to add other nodes to swarm and didn't save off that join token,
# this will reprint it for adding a worker node
COMMAND='docker swarm join-token worker'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# now create a service on the manager node and it will be deployed to the swarm 
COMMAND='docker service create --name hello orax/alpine-armhf ping localhost'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# now scale that sevice so we have 4 running
COMMAND='docker service scale hello=4'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# now 12
COMMAND='docker service scale hello=12'
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

# now 0
COMMAND='docker service scale hello=0'
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

# now 2
COMMAND='docker service scale hello=2'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# remove service
COMMAND='docker service rm hello'
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

# since the orax/alpine-armhf image is for the ARM processor, it won't run on x86
# so now let's start the same service but constrain it only to the worker nodes
# now create a service on the manager node and it will be deployed to the swarm 
COMMAND='docker service create --name hello-arm --constraint node.role!=manager --replicas=10 orax/alpine-armhf ping localhost'
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

#
# Now show fault recovery by unplugging a node.
# The services that were on the dead node will restart on other nodes

# show how many are running/requested
COMMAND='docker service ls'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

#
# Plug back in node
#

# remove service
COMMAND='docker service rm hello-arm'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

#
# Now lets show load balancing via the docker mesh network.
# The Pi's are running a WS2812 program called sparkleNative.py (see that folder for details).
# Start sparkle on the Pi's and then run curl against the manager to see the load balancing
COMMAND='docker service create --name sparkle --constraint node.role==worker --replicas=4 -p 4000:4000 roadster/sparkles'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# make it sparkle
COMMAND='curl http://dnuc:4000/sparkle'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# make it sparkle
COMMAND='curl http://dnuc:4000/sparkle'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# make it sparkle
COMMAND='curl http://dnuc:4000/sparkle'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# make it sparkle
COMMAND='curl http://dnuc:4000/sparkle'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# make it sparkle
COMMAND='curl http://dnuc:4000/sparkle'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause

# remove service
COMMAND='docker service rm sparkle'
clear
echo
echo -e $ ${HL}${COMMAND}${NC} | randtype -m 0 -t 10,20000
${COMMAND}
echo
pause






















