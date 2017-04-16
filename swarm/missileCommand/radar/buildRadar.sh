#!/bin/bash

docker build -t roadster/missile-command-radar:latest .

docker save -o roadster.missile.command.radar.tar roadster/missile-command-radar:latest

mv roadster.missile.command.radar.tar ../../../tars/.

scp ../../../tars/roadster.missile.command.radar.tar pirate@pi-zero:.
