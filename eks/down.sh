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


echo -e "${COL}Deleting ingress...${NOC}"
kubectl delete -f load-balancer/ingress.yaml


echo -e "${COL}Deleting services...${NOC}"
kubectl delete -f weather-service/service.yaml
kubectl delete -f hikes-service/service.yaml


echo -e "${COL}Deleting prometheus...${NOC}"
kubectl delete -f monitoring/
kubectl delete -f monitoring/kube-state-metrics/


echo -e "${COL}Deleting NLB...${NOC}"
kubectl delete -f load-balancer/nginx-nlb.yaml


echo -e "${COL}Deleting stack $STACK_NAME...${NOC}"
aws cloudformation delete-stack \
        --stack-name "$STACK_NAME"
