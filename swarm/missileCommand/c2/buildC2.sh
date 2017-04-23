#!/bin/bash

docker build -t roadster/missile-command-c2:latest .

docker save -o roadster.missile.command.c2.tar roadster/missile-command-c2:latest

mv roadster.missile.command.c2.tar ../../../tars/.

docker images roadster/missile-command-c2:latest

