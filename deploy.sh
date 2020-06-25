docker build -t jagveer/multi-client:latest -t jagveer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jagveer/multi-server:latest -t jagveer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jagveer/multi-worker:latest -t jagveer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jagveer/multi-client:latest
docker push jagveer/multi-server:latest
docker push jagveer/multi-worker:latest

docker push jagveer/multi-client:$SHA
docker push jagveer/multi-server:$SHA
docker push jagveer/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=jagveer/multi-server:$SHA
kubectl set image deployment/client-deployment client=jagveer/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=jagveer/multi-worker:$SHA