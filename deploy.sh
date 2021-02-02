docker build -t gnakatani/multi-client -f ./client/Dockerfile ./client
docker build -t gnakatani/multi-server -f ./server/Dockerfile ./server
docker build -t gnakatani/multi-worker -f ./worker/Dockerfile ./worker
docker push gnakatani/multi-client
docker push gnakatani/multi-server
docker push gnakatani/multi-worker
docker push gnakatani/multi-client
docker push gnakatani/multi-server
docker push gnakatani/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gnakatani/multi-server
kubectl set image deployments/client-deployment client=gnakatani/multi-client
kubectl set image deployments/worker-deployment worker=gnakatani/multi-worker