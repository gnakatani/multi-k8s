# Build all images, tag
docker build -t gnakatani/multi-client:latest -f ./client/Dockerfile ./client
docker build -t gnakatani/multi-server:latest -f ./server/Dockerfile ./server
docker build -t gnakatani/multi-worker:latest -f ./worker/Dockerfile ./worker
# push latest to docker hub
docker push gnakatani/multi-client:latest
docker push gnakatani/multi-server:latest
docker push gnakatani/multi-worker:latest
# apply all configs in k8s
kubectl apply -f k8s kubectl set image deployments/server-deployment server=gnakatani/multi-server kubectl set image deployments/client-deployment client=gnakatani/multi-client kubectl set image deployments/worker-deployment worker=gnakatani/multi-worker