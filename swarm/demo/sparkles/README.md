# Sparkles

* Sparkles is a docker container that communicates thru the GPIO pins to control a WS2812 strip. 

   https://www.adafruit.com/product/1426
   
* These can be driven with the Pimoroni Unicorn python library

   https://github.com/pimoroni/unicorn-hat

* Alex Ellis has a nice example of creating a Docker image and running with --priviledged

   https://github.com/alexellis/docker-arm/tree/master/images/armv6/unicorn-arm

* The sparkles image exposes interfaces on port 3000 to sparkle the LEDs
   * http://localhost:3000/sparklenative
   * http://localhost:3000/calcnative
   * http://localhost:3000/firenative
   
* This is all great but unfortunately docker service create does NOT support --priviledged

* So ... This is a hack of a workaround.
   * The dockerfile in this folder will create an image that can be run as a stand-alone container
      * Run the buildSparkles.sh ON a Pi. If you build on an x86 machine, it will not run on a Pi
      * Look at runSparkles.sh to see how to run as a container

   * The hack is that we also will install the unicorn and pyhton scripts locally that exposes the sparkles interfaces. And then run the same docker image as a docker swarm service but use a different set of interfaces.
      * http://localhost:3000/sparkle
      * http://localhost:3000/calc
      * http://localhost:3000/fire
      
   * The non native interface will call the native interface that runs on the docker host.

* For each Pi, build the SD image using hypriot image and flash tool
   * Refer to the README.md file in the RaspberryPi folder of this repo 

* Boot up Pi, ssh with pirate credentials

* Copy all files in this sparkles folder to a saprkles folder on the Pi
   * scp -r sparkles pirate@<host name>:.

* Run the install Unicorn script
   * sudo ./installUnicorn.sh

* Make a crontab entry so that the sparkles python script is run on boot
   * crontab -e
   * @reboot sudo /home/pirate/sparkles/runSparklesNative.sh
   
* The neoPixel stick is connected to the pi
   neo pin GND -> pi pin 2 (GND)
   neo pin DIN -> pi pin 6 (5v)
   neo pin VDC -> pi pin 12 (GPIO18)
   
* Refer to the pi3_gpio.pdf file in this folder

