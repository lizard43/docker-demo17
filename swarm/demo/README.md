# A general Swarm demo to show basic connectivity and features of Docker swarm

docker swarm init


Start the Swarm Visualizer on the manager node

On other nodes

docker swarm join


on manager

docker service create --name hello1 --publish 3000:3000 --replicas=2 alexellis2/arm-alpinehello
curl -4 localhost:3000
docker service rm hello1

docker service scale hello=5