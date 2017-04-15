#!/bin/bash

# access via http://<host>:4000/sparkles
# access via http://<host>:4000/online
# access via http://<host>:4000/calc
# access via http://<host>:4000/fire
#
docker run -it --rm --name sparkles --privileged  -p 4000:4000 roadster/sparkles
