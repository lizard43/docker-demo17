FROM alexellis2/python-gpio-arm:armv6

RUN apt-get -q update && \
	apt-get -qy install python-dev python-pip python-netifaces && \
	pip install netifaces && \
   apt-get -qy remove python-dev && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get -qy clean all
	
RUN easy_install web.py

COPY sparkles.py .

EXPOSE 4000

CMD ["python2", "./sparkles.py"]
