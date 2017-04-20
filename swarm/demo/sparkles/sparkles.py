#!/usr/bin/python
import os
import web
import urllib2
import netifaces
from time import sleep

os.environ["PORT"] = "4000"

gws=netifaces.gateways()
print("gws: ", gws);

mygateway = gws['default'].values()[0][0]

print("gateway: ", mygateway);

urls = (
    '/sparkles', 'sparkles'
)

app = web.application(urls, globals())

# this does a dumb sparkle thing on the ws2812
# by calling the native version on the host
class sparkles:
    def GET(self):
    
      url = "http://"
      url += mygateway
      url += ":3000/sparkles"
      
      print("reading: ", url)
    
      myhost = urllib2.urlopen(url).read()

      return myhost

if __name__ == "__main__":
    app.run()
