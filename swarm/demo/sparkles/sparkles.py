#!/usr/bin/python
import web
import os
import urllib2
import netifaces
from time import sleep

os.environ["PORT"] = "4000"
myhost = os.uname()[1]

gws=netifaces.gateways()
print("gws: ", gws);

mygateway = gws['default'].values()[0][0]

print("gateway: ", mygateway);

urls = (
    '/sparkles', 'sparkles',
    '/calc', 'calc',    
    '/fire', 'fire',
    '/online', 'online'
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
    
      urllib2.urlopen(url).read()

      return myhost

# this does a dumb green bar effect thing on the ws2812
# by calling the native version on the host
class calc:
    def GET(self):
    
      url = "http://"
      url += mygateway
      url += ":3000/calc"
      
      print("reading: ", url)
      urllib2.urlopen(url).read()

      return myhost

# this does a dumb blue bar effect thing on the ws2812
# by calling the native version on the host
class online:
    def GET(self):
    
      url = "http://"
      url += mygateway
      url += ":3000/online"
      
      print("reading: ", url)
      urllib2.urlopen(url).read()

      return myhost

# this does a dumb red bar effect thing on the ws2812
# by calling the native version on the host
class fire:
    def GET(self):
    
      url = "http://"
      url += mygateway
      url += ":3000/fire"
      
      print("reading: ", url)
      urllib2.urlopen(url).read()

      return myhost

spark = online()
spark.GET()

if __name__ == "__main__":
    app.run()
