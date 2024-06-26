docker build -t mallama/multi-client:latest -t mallama/multi-client:$SHA -f  ./client/Dockerfile ./client
docker build -t mallama/multi-server:latest -t mallama/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mallama/multi-worker:latest -t mallama/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mallama/multi-client:latest
docker push mallama/multi-server:latest
docker push mallama/multi-worker:latest

docker push mallama/multi-client:$SHA
docker push mallama/multi-server:$SHA
docker push mallama/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mallama/multi-server:$SHA
kubectl set image deployments/client-deployment client=mallama/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mallama/multi-worker:$SHA
