#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath=schnebelalexander/udacity-project-ai

# Step 2:  
# Authenticate & tag
# At the password prompt, enter the personal access token
echo "Docker ID and Image: $dockerpath"
docker login --username schnebelalexander
docker tag api "$dockerpath:v1.0"

# Step 3:
# Push image to a docker repository
docker push $dockerpath
