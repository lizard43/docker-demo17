#!/bin/bash

docker build -t roadster/missile-command-battery:latest .

docker save -o roadster.missile.command.battery.tar roadster/missile-command-battery:latest

mv roadster.missile.command.battery.tar ../../../tars/.

scp ../../../tars/roadster.missile.command.battery.tar pirate@pi-zero:.
