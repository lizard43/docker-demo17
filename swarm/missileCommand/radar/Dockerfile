FROM forumi0721alpinearmhf/alpine-armhf-nodejs:latest
MAINTAINER roadster

WORKDIR /radar

ADD js /radar/js
ADD node_modules /radar/node_modules

CMD ["node", "/radar/js/radar.js"]
