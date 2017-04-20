#!/usr/bin/python
from random import randint
import web
import unicornhat as unicorn
import os
import urllib2
from time import sleep

os.environ["PORT"] = "3000"
myhost = os.uname()[1]

urls = (
    '/sparkles', 'sparkles'
)

app = web.application(urls, globals())

unicorn.set_layout(unicorn.AUTO)
unicorn.rotation(0)
unicorn.brightness(0.5)
width,height=unicorn.get_shape()

# this does a dumb sparkle thing on the ws2812
# it works either by running sprint natively on the pi OR
# in a docker container that is run with --priviledged BUT
# it will NOT work as a swarm service
class sparkles:
    def GET(self):
    
        for b in range(1, 380):
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

if __name__ == "__main__":

   spark = sparkles()
   spark.GET()

   app.run()
