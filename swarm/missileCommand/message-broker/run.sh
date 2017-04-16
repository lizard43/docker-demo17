#!/bin/bash

docker run --rm -it -p 1883:1883 -p 8000:8000 roadster/mqtt-broker
