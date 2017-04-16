FROM forumi0721alpinearmhf/alpine-armhf-nodejs:latest
MAINTAINER roadster

WORKDIR /battery

ADD js /battery/js
ADD node_modules /battery/node_modules

CMD ["node", "/battery/js/battery.js"]
