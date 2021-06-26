docker build -t tbheng/multi-client:latest -t tbheng/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tbheng/multi-server:latest -t tbheng/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tbheng/multi-worker:latest -t tbheng/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tbheng/multi-client:latest
docker push tbheng/multi-server:latest
docker push tbheng/multi-worker:latest
docker push tbheng/multi-client:$SHA
docker push tbheng/multi-server:$SHA
docker push tbheng/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tbheng/multi-client:$SHA
kubectl set image deployments/server-deployment server=tbheng/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tbheng/multi-worker:$SHA