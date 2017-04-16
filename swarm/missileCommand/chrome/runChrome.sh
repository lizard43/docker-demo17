#!/bin/bash
xhost +
DIR=$HOME/.chromedocker
mkdir -p $DIR/pki $DIR/share $DIR/config $DIR/chrome $HOME/Downloads

docker run --rm -d \
        --memory 2gb \
        -u $(id -u):$(id -g) \
        -v $DIR/config:/.config \
        -v $DIR/pki:/.pki \
        -v /etc/localtime:/etc/localtime:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=unix$DISPLAY \
        -v $HOME/Downloads:/Downloads \
        -v $DIR:/.local \
        -v $DIR:/.gnome \
        --device /dev/snd \
        --device /dev/dri \
        --device /dev/bus/usb \
        --group-add audio \
        --group-add video \
        -v /etc/hosts:/etc/hosts:ro \
        -v /var/run:/var/run \
        --cap-drop all \
        --name chrome \
        --rm \
        --network=command-net \
        jess/chrome --user-data-dir=/.local/chrome http://c2:8080 $*
