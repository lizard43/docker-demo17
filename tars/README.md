# Docker images for the Demo

These are here because ourdemo server can not be connected to the internet and these images are 'sneaker net' copied to the server via thumb drive.

If your demo server is connected to the internet, don't use these, build from the applicable docker files

These were saved from the development server like this:
         
         docker save -o <filename>.tar <image name>:<tag>

Restore these to the target demo system like this:

         docker load -i <filename>.tar
