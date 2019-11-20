#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath=schnebelalexander/udacity-project-ai
version=v1.0

echo "Start Pod ..."

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run udacity-ai \
  --generator=run-pod/v1 \
  --image=$dockerpath:latest \
  --replicas=1 \
  --labels="version=$version,app=udacity-ai-api,env=production" \
  --port=80

echo "Currently running Pods: "

# Step 3:
# List kubernetes pods
kubectl get pods

while [[ 
  $(kubectl get pods udacity-ai -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" 
]]; do echo "Waiting for Pod to get ready... sleep for 5 seconds" && sleep 5; done

echo "Pod seems to be ready! See:"

kubectl get pods

echo "Now forwarding..."

# Step 4:
# Forward the container port to a host
kubectl port-forward udacity-ai 8000:80
