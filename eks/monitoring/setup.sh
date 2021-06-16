#!/bin/bash
set -e

# parameters
REGION=us-east-1
STACK_NAME=$1

# colors
COL='\033[1;36m'
NOC='\033[0m'


echo -e "\n${COL}Updating kubeconfig file...${NOC}"
aws eks update-kubeconfig --region "$REGION" \
	--name "$STACK_NAME"-eks-cluster


echo -e "${COL}Creating monitoring namespace${NOC}"
kubectl create namespace monitoring


echo -e "${COL}Deploying prometheus${NOC}"
kubectl create -f cluster-role.yaml
kubectl create -f config-map.yaml
kubectl create -f prometheus-deployment.yaml
kubectl create -f prometheus-service.yaml