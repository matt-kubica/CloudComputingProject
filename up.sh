#!/bin/bash
set -e


# parameters
REGION=us-east-1						# any region
NUM_WORKER_NODES=3 						# for now, value between 2 and 3
WORKER_NODES_INSTANCE_TYPE=t2.micro 	# [t2.micro, t2.small, t3.medium]
STACK_NAME=ccds-test-stack
KEY_PAIR_NAME=ccds-test-stack-key-pair


# colors
COL='\033[1;36m'
NOC='\033[0m'


echo -e "${COL}Setting up $STACK_NAME (may take up to 15 minutes)...${NOC}"
aws cloudformation deploy \
  --region "$REGION" \
  --template-file eks-provisioning.yaml \
  --capabilities CAPABILITY_IAM \
  --stack-name "$STACK_NAME" \
  --parameter-overrides \
      KeyPairName="$KEY_PAIR_NAME" \
      NumWorkerNodes="$NUM_WORKER_NODES" \
      WorkerNodesInstanceType="$WORKER_NODES_INSTANCE_TYPE"


echo -e "\n${COL}Updating kubeconfig file...${NOC}"
aws eks update-kubeconfig --region "$REGION" \
	--name "$STACK_NAME"-eks-cluster


echo -e "\n${COL}Adding administartors to cluster...${NOC}"
kubectl apply -f rbac.yaml
kubectl apply -f aws-auth-configmap.yaml


echo -e "\n${COL}Creating EKS namespace...${NOC}"
kubectl create namespace ccds-test-namespace


echo -e "\n${COL}Deploying application...${NOC}"
kubectl apply -f deployment.yaml
kubectl expose deployment ccds-test-deployment \
	-n ccds-test-namespace --type=LoadBalancer --name=ccds-test-service


echo -e "\n${COL}Listing services...${NOC}"
kubectl get svc -A