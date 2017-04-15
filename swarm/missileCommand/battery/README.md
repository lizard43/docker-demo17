# Docker image for the Missile Battery

Build:
* docker build -t roadster/missile-command-battery:latest .

* Uses MQTT to receive and send messages

* This listens for MQTT missile messages
   * command/missile'

* This publishes MQTT rocket messages
   * 'command/rocket'
