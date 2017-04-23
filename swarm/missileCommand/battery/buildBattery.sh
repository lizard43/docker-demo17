#!/bin/bash

docker build -t roadster/missile-command-battery:latest .

docker save -o roadster.missile.command.battery.tar roadster/missile-command-battery:latest

mv roadster.missile.command.battery.tar ../../../tars/.

docker images roadster/missile-command-battery:latest

echo pi-three-1
scp ../../../tars/roadster.missile.command.battery.tar pirate@pi-three-1.local:.
ssh pirate@pi-three-1.local "docker load -i roadster.missile.command.battery.tar"
ssh pirate@pi-three-1.local "docker images roadster/missile-command-battery:latest"

echo pi-three-2
scp ../../../tars/roadster.missile.command.battery.tar pirate@pi-three-2.local:.
ssh pirate@pi-three-2.local "docker load -i roadster.missile.command.battery.tar"
ssh pirate@pi-three-2.local "docker images roadster/missile-command-battery:latest"

echo pi-three-3
scp ../../../tars/roadster.missile.command.battery.tar pirate@pi-three-3.local:.
ssh pirate@pi-three-3.local "docker load -i roadster.missile.command.battery.tar"
ssh pirate@pi-three-3.local "docker images roadster/missile-command-battery:latest"


