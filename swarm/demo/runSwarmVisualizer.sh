#!/bin/bash

docker run -dt --rm -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock  manomarks/visualizer
