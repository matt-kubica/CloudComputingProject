# CCDS project

## Idea

Create an easily managable and scalable micro-services cloud environment where we could run or remove as many services as we needed.

## Solution

Deployment of services using Kubernetes in the AWS cloud - EKS!

This allows us to deploy any amount of micro services in the form of containers. In our case we used Docker Runtime.

We can scale up and scale down our virtual hardwawre (increase the number of worker nodes or their resources) depending on our current needs.



## How it was developed

### Infrastructure Provisioning

Whole infrastructure is provisioned using Cloud Formation templates. Requirements for EKS cluster are following:
-  VPC with at least 2 subnets located in different availability zones and InternetGateway
- IAM roles for operating on ControlPlane and WorkerNodes
- SecurityGroup and Ingress / Egress rules for communicating between ControlPlane and WorkerNodes
- EKS NodeGroup (optionally could be Fragate)

#### AWS VPC stack
![AWS VPC](https://raw.githubusercontent.com/matt-kubica/CloudComputingProject/master/assets/vpc-infrastructure.png)

#### AWS EKS stack
VPC stack from above is nested inside EKS stack.
![AWS EKS](https://raw.githubusercontent.com/matt-kubica/CloudComputingProject/master/assets/eks-infrastructure.png)
*Diagrams generated using CloudFormation Designer*

### Cluster Topology


#### Load Ballancing
In order to access services from outside of the cluster LoadBallancer needs to be set up. This is actually AWS service that doesn't live inside a cluster, but is controlled from inside a cluster. It is possible thanks to concept of LoadBallancerController. It allows to specify routes, redirections and forwardings using k8s's native Ingress entity. Implementation of external load ballancer, that we have choosen is NginX. 

#### Worker Services
Our cluster consist of two container images that are deployed using k8s's deployment, replicaset and service concepts. Main goal of those containers is to execute some dummy workload on a request.

#### Cluster Metrics Monitoring
In order to monitor metrics in comprahensive and human readable form Prometheus is used for data scrapping / collecting and Grafana is used for data presentation.

![Monitoring](https://raw.githubusercontent.com/matt-kubica/CloudComputingProject/master/assets/grafana.png)

#### Cluster Diagram
![EKS Cluster](https://raw.githubusercontent.com/matt-kubica/CloudComputingProject/master/assets/cluster-diagram.png)

#### Stress Testing

In order to check out how our cluster behave under certain ammount of requests we have deployed Lambda Function.

![Lambda](https://raw.githubusercontent.com/matt-kubica/CloudComputingProject/master/assets/lambda-diagram.png)

## Motivation of design decisions

We were choosing between EKS and ECS as they both offered pretty much the same service but since EKS is built on Kubernetes and ECS is more of a AWS specific container orchestration implementation we decided that it will be more useful to go with the former.


## Issues we faced 
Entry level of Kubernetes Cluster operating is pretty high, without any prior experience with microservices and K8S in particular, deploying such a cluster was a bit challenging. Regarding fact that EKS service is not part of AWS Free Tier, we had to implement efficient way of setting the whole stack for EKS cluster. CloudFormation turned out to be perfect sollution, however, it also required adoption of several rules and concepts. The most challenging part however, was troubleshooting. We faced a lot of issues throught whole project and sometimes it's really a murder to solve them.