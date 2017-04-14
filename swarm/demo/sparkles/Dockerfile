FROM alexellis2/python-gpio-arm:armv6

WORKDIR /root/
ADD ./unicorn-hat/ ./unicorn-hat/

RUN apt-get -q update && \
	apt-get -qy install python-dev python-pip gcc make python-netifaces && \
	pip install rpi-ws281x && \
	pip install UnicornHat && \
	pip install netifaces && \
   apt-get -qy remove python-dev gcc make && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get -qy clean all
	
RUN easy_install web.py

COPY restSparkles.py .

EXPOSE 3000

CMD ["python2", "./restSparkles.py"]
