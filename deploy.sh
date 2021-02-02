# Build all images, tag
docker build -t gnakatani/multi-client:latest -t gnakatani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gnakatani/multi-server:latest -t gnakatani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gnakatani/multi-worker:latest -t gnakatani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push latest to docker hub
docker push gnakatani/multi-client:latest
docker push gnakatani/multi-server:latest
docker push gnakatani/multi-worker:latest

# push specific version to docker hub
docker push gnakatani/multi-client:$SHA
docker push gnakatani/multi-server:$SHA
docker push gnakatani/multi-worker:$SHA


# apply all configs in k8s
kubectl apply -f k8s

# 
kubectl set image deployments/server-deployment server=gnakatani/multi-server:$SHA
kubectl set image deployments/client-deployment client=gnakatani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gnakatani/multi-worker:$SHA

 




