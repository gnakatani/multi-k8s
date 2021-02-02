docker build -t gnakatani/multi-client -t gnakatani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gnakatani/multi-worker -f ./worker/Dockerfile ./worker
docker push gnakatani/multi-client:latest
docker push gnakatani/multi-client:$SHA
docker push stephengrider/multi-server:latest
docker push stephengrider/multi-server:$SHA
docker push gnakatani/multi-worker
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server kubectl set image deployments/client-deployment client=gnakatani/multi-client kubectl set image deployments/worker-deployment worker=gnakatani/multi-worker