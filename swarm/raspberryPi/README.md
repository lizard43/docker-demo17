# Raspberry Pi w/ Docker

* We'll use several Raspberry Pi's as part of the swarm demo.

* The Hypriot Docker Image for Raspberry Pi is one of the better options to get going on a Pi with the latest Docker version.

    https://blog.hypriot.com/downloads/

* Download an image from the above link and write to your SD card using Hypriot's 'flash' utility which can be found here:

    https://github.com/hypriot/flash

* Example:

    ./flash -n <host> -s <ssid> -p <password> hypriotos-rpi-v1.4.0-Docker-17.03.0-ce.img.zip

* Start your Pi with the flashed SD card and enjoy instant Docker awesomeness.

* The Hypriot image comes with one user with sudo privileges:

   * username: pirate
   * password: hypriot

