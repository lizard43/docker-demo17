#!/usr/bin/python
from random import randint
import web
import unicornhat as unicorn
import os
import urllib2
from time import sleep
import netifaces

os.environ["PORT"] = "3000"
myhost = os.uname()[1]

gws=netifaces.gateways()
print("gws: ", gws);

mygateway = gws['default'].values()[0][0]

print("gateway: ", mygateway);

urls = (
    '/sparkles', 'sparkles',
    '/sparkles-native', 'sparklesnative',
    
    '/calc', 'calc',
    '/calc-native', 'calcnative',
    
    '/fire', 'fire',
    '/fire-native', 'firenative',
)

app = web.application(urls, globals())

# this does a dumb sparkle thing on the ws2812
# it works either by running sprint natively on the pi OR
# in a docker container that is run with --priviledged BUT
# it will NOT work as a swarm service
class sparklesnative:
    def GET(self):
    
        unicorn.set_layout(unicorn.AUTO)
        unicorn.rotation(0)
        unicorn.brightness(0.5)
        width,height=unicorn.get_shape()

        for b in range(1, 480):
            x = randint(0, (width-1))
            y = randint(0, (height-1))
            r = randint(0, 255)
            g = randint(0, 255)
            b = randint(0, 255)
            unicorn.set_pixel(x, y, r, g, b)
            unicorn.show()

        for b in range(0, width):
            unicorn.set_pixel(b,0,0,0,0)
            unicorn.show()

        return myhost

# this does a dumb sparkle thing on the ws2812
# by calling the native version on the host
class sparkles:
    def GET(self):
    
      url = "http://"
      url += mygateway
      url += ":3000/sparkles-native"
      
      print("reading: ", url)
    
      urllib2.urlopen(url).read()

      return myhost

# this does a dumb green bar effect thing on the ws2812
# it works either by running sprint natively on the pi OR
# in a docker container that is run with --priviledged BUT
# it will NOT work as a swarm service
class calcnative:
    def GET(self):
    
        unicorn.set_layout(unicorn.AUTO)
        unicorn.rotation(0)
        unicorn.brightness(0.5)
        width,height=unicorn.get_shape()

        for z in range(1, 4):

            for x in range(0, 8, 1): 
               y = 0
               r = 0
               g = 255
               b = 0
               unicorn.set_pixel(x, y, r, g, b)
               unicorn.show()
               sleep(0.05)

            for x in range(8, 0, -1):      
               y = 0
               r = 0
               g = 0
               b = 0
               unicorn.set_pixel(x, y, r, g, b)
               unicorn.show()
               sleep(0.05)

            for x in range(8, 0, -1): 
               y = 0
               r = 0
               g = 255
               b = 0
               unicorn.set_pixel(x, y, r, g, b)
               unicorn.show()
               sleep(0.05)

        # turn all off
        unicorn.set_pixel(0, 0, 0, 0, 0)
        unicorn.set_pixel(1, 0, 0, 0, 0)
        unicorn.set_pixel(2, 0, 0, 0, 0)
        unicorn.set_pixel(3, 0, 0, 0, 0)
        unicorn.set_pixel(4, 0, 0, 0, 0)
        unicorn.set_pixel(5, 0, 0, 0, 0)
        unicorn.set_pixel(6, 0, 0, 0, 0)
        unicorn.set_pixel(7, 0, 0, 0, 0)
        unicorn.show()
 
        return myhost

# this does a dumb green bar effect thing on the ws2812
# by calling the native version on the host
class calc:
    def GET(self):
    
      url = "http://"
      url += mygateway
      url += ":3000/calc-native"
      
      print("reading: ", url)
      urllib2.urlopen(url).read()

      return myhost

# this does a dumb red bar effect thing on the ws2812
# it works either by running sprint natively on the pi OR
# in a docker container that is run with --priviledged BUT
# it will NOT work as a swarm service
class firenative:
    def GET(self):
    
        unicorn.set_layout(unicorn.AUTO)
        unicorn.rotation(0)
        unicorn.brightness(0.5)
        width,height=unicorn.get_shape()

        for z in range(1, 5):

            for red in range(100, 255, 5): 
               unicorn.set_pixel(0, 0, red, 0, 0)
               unicorn.set_pixel(1, 0, red, 0, 0)
               unicorn.set_pixel(2, 0, red, 0, 0)
               unicorn.set_pixel(3, 0, red, 0, 0)
               unicorn.set_pixel(4, 0, red, 0, 0)
               unicorn.set_pixel(5, 0, red, 0, 0)
               unicorn.set_pixel(6, 0, red, 0, 0)
               unicorn.set_pixel(7, 0, red, 0, 0)
               unicorn.show()
               sleep(0.01)

            for red in range(245, 100, -5): 
               unicorn.set_pixel(0, 0, red, 0, 0)
               unicorn.set_pixel(1, 0, red, 0, 0)
               unicorn.set_pixel(2, 0, red, 0, 0)
               unicorn.set_pixel(3, 0, red, 0, 0)
               unicorn.set_pixel(4, 0, red, 0, 0)
               unicorn.set_pixel(5, 0, red, 0, 0)
               unicorn.set_pixel(6, 0, red, 0, 0)
               unicorn.set_pixel(7, 0, red, 0, 0)
               unicorn.show()
               sleep(0.01)

        # turn all off
        unicorn.set_pixel(0, 0, 0, 0, 0)
        unicorn.set_pixel(1, 0, 0, 0, 0)
        unicorn.set_pixel(2, 0, 0, 0, 0)
        unicorn.set_pixel(3, 0, 0, 0, 0)
        unicorn.set_pixel(4, 0, 0, 0, 0)
        unicorn.set_pixel(5, 0, 0, 0, 0)
        unicorn.set_pixel(6, 0, 0, 0, 0)
        unicorn.set_pixel(7, 0, 0, 0, 0)
        unicorn.show()

        return myhost

# this does a dumb red bar effect thing on the ws2812
# by calling the native version on the host
class fire:
    def GET(self):
    
      url = "http://"
      url += mygateway
      url += ":3000/fire-native"
      
      print("reading: ", url)
      urllib2.urlopen(url).read()

      return myhost


spark = sparklesnative()
spark.GET()

if __name__ == "__main__":
    app.run()
