#!/bin/bash

# Build base image
docker build -t apache/rocketmq-base:4.7.1 --build-arg version=4.7.1 ./rocketmq-base

# Build namesrv and broker
docker build -t apache/rocketmq-namesrv:4.7.1-k8s ./kubernetes/rocketmq-namesrv
docker build -t apache/rocketmq-broker:4.7.1-k8s ./kubernetes/rocketmq-broker

# Run namesrv and broker on your Kubernetes cluster.
kubectl create -f kubernetes/deployment.yaml
