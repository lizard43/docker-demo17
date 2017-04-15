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
    '/sparkles', 'sparkles',    
    '/online', 'online',    
    '/calc', 'calc',    
    '/fire', 'fire'
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

# this does a dumb green bar effect thing on the ws2812
# it works either by running sprint natively on the pi OR
# in a docker container that is run with --priviledged BUT
# it will NOT work as a swarm service
class calc:
    def GET(self):
    
        for z in range(1, 3):

            for x in range(0, 9, 1): 
               y = 0
               r = 0
               g = 255
               b = 0
               unicorn.set_pixel(x, y, r, g, b)
               unicorn.show()
               sleep(0.05)

            for x in range(9, 0, -1):      
               y = 0
               r = 0
               g = 0
               b = 0
               unicorn.set_pixel(x, y, r, g, b)
               unicorn.show()
               sleep(0.05)

            for x in range(9, 0, -1): 
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
        unicorn.set_pixel(8, 0, 0, 0, 0)
        unicorn.set_pixel(9, 0, 0, 0, 0)
        unicorn.show()
 
        return myhost

# this does a dumb blue bar effect thing on the ws2812
# it works either by running sprint natively on the pi OR
# in a docker container that is run with --priviledged BUT
# it will NOT work as a swarm service
class online:
    def GET(self):
    
        for z in range(1, 3):

            for x in range(0, 9, 1): 
               y = 0
               r = 0
               g = 0
               b = 255
               unicorn.set_pixel(x, y, r, g, b)
               unicorn.show()
               sleep(0.05)

            for x in range(9, 0, -1):      
               y = 0
               r = 0
               g = 0
               b = 0
               unicorn.set_pixel(x, y, r, g, b)
               unicorn.show()
               sleep(0.05)

            for x in range(9, 0, -1): 
               y = 0
               r = 0
               g = 0
               b = 255
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
        unicorn.set_pixel(8, 0, 0, 0, 0)
        unicorn.set_pixel(9, 0, 0, 0, 0)
        unicorn.show()
 
        return myhost

# this does a dumb red bar effect thing on the ws2812
# it works either by running sprint natively on the pi OR
# in a docker container that is run with --priviledged BUT
# it will NOT work as a swarm service
class fire:
    def GET(self):
    
        for z in range(1, 3):

            for red in range(100, 255, 5): 
               unicorn.set_pixel(0, 0, red, 0, 0)
               unicorn.set_pixel(1, 0, red, 0, 0)
               unicorn.set_pixel(2, 0, red, 0, 0)
               unicorn.set_pixel(3, 0, red, 0, 0)
               unicorn.set_pixel(4, 0, red, 0, 0)
               unicorn.set_pixel(5, 0, red, 0, 0)
               unicorn.set_pixel(6, 0, red, 0, 0)
               unicorn.set_pixel(7, 0, red, 0, 0)
               unicorn.set_pixel(8, 0, red, 0, 0)
               unicorn.set_pixel(9, 0, red, 0, 0)
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
               unicorn.set_pixel(8, 0, red, 0, 0)
               unicorn.set_pixel(9, 0, red, 0, 0)
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
        unicorn.set_pixel(8, 0, 0, 0, 0)
        unicorn.set_pixel(9, 0, 0, 0, 0)
        unicorn.show()

        return myhost

if __name__ == "__main__":

   spark = sparkles()
   spark.GET()

   app.run()
