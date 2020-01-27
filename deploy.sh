#!/bin/bash

# Minikube magic to use it's registry
eval $(minikube docker-env)

docker build -t todo:latest .

# Create secret. Should be placed anywhere, but not in git!
kubectl create secret generic todo-secrets --from-literal=SECRET_KEY='lksdf98wrhkjs88dsf8-324ksdm' --from-literal=DATABASE_NAME='django' \
    --from-literal=DATABASE_HOST='todo-postgresql.default.svc.cluster.local' --from-literal=DATABASE_USER='postgres'

helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm dependency build

# Helm update
helm upgrade -i todo --set postgresql.postgresqlDatabase=django . -f values.yaml

# Waiting for pods up and running...
sleep 120

# Open service on NodePort
minikube service todo
