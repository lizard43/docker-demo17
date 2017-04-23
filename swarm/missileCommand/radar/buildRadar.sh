#!/bin/bash

docker build -t roadster/missile-command-radar:latest .

docker save -o roadster.missile.command.radar.tar roadster/missile-command-radar:latest

mv roadster.missile.command.radar.tar ../../../tars/.

docker images roadster/missile-command-radar:latest

echo pi-three-1
scp ../../../tars/roadster.missile.command.radar.tar pirate@pi-three-1.local:.
ssh pirate@pi-three-1.local "docker load -i roadster.missile.command.radar.tar"
ssh pirate@pi-three-1.local "docker images roadster/missile-command-radar:latest"

echo pi-three-2
scp ../../../tars/roadster.missile.command.radar.tar pirate@pi-three-2.local:.
ssh pirate@pi-three-2.local "docker load -i roadster.missile.command.radar.tar"
ssh pirate@pi-three-2.local "docker images roadster/missile-command-radar:latest"

echo pi-three-3
scp ../../../tars/roadster.missile.command.radar.tar pirate@pi-three-3.local:.
ssh pirate@pi-three-3.local "docker load -i roadster.missile.command.radar.tar"
ssh pirate@pi-three-3.local "docker images roadster/missile-command-radar:latest"


