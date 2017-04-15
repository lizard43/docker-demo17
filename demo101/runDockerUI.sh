#!/bin/bash

docker run -d --name docker-ui -p 80:9000 --rm -v /var/run/docker.sock:/var/run/docker.sock dnuc:5000/dockerui:latest

