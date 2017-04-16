FROM openjdk:latest
MAINTAINER roadster

RUN apt-get update && apt-get install -y mosquitto-clients

COPY mqtt-spy-0.5.4-jar-with-dependencies.jar /.
COPY mqtt-spy /root/mqtt-spy

COPY subMissile.sh /.
COPY subRocket.sh /.

ENV CLASSPATH .:./mqtt-spy-0.5.4-jar-with-dependencies.jar

CMD ["java", "-cp", ".:./mqtt-spy-0.5.4-jar-with-dependencies.jar", "pl.baczkowicz.mqttspy.Main"]
