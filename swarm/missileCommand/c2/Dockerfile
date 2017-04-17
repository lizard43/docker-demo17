FROM mhart/alpine-node:latest
MAINTAINER roadster

RUN npm install -g http-server

WORKDIR /command

ADD index.html /command/.
ADD node_modules /command/node_modules

ADD js /command/js/.

EXPOSE 8080

CMD ["http-server", "/command"]
