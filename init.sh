#!/bin/bash

# Using Ubuntu

# Install minikube 
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

# Start minikube
minikube start

# Enable metrics-server, to setup hpa 
minikube addons enable metrics-server
