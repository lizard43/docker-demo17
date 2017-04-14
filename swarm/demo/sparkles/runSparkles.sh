#!/bin/bash

# access via http://<host>:3000/sparklesnative
# access via http://<host>:3000/calcnative
# access via http://<host>:3000/firenative
#
docker run -it --rm --name rest --privileged  -p 3000:3000 roadster/sparkles
