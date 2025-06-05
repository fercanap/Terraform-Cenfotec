#!/bin/bash

# Región a utilizar
REGION="us-west-1"

echo "### DIAGNÓSTICO DE INFRAESTRUCTURA EN AWS ($REGION) ###"

echo -e "\n--- TARGET GROUPS ---"
aws elbv2 describe-target-groups --region $REGION

echo -e "\n--- LISTENERS ---"
aws elbv2 describe-listeners \
  --load-balancer-arn $(aws elbv2 describe-load-balancers --region $REGION --query "LoadBalancers[?contains(DNSName, 'alb-fercanap')].LoadBalancerArn" --output text) \
  --region $REGION

echo -e "\n--- LOAD BALANCERS ---"
aws elbv2 describe-load-balancers --region $REGION

echo -e "\n--- AUTO SCALING GROUPS ---"
aws autoscaling describe-auto-scaling-groups --region $REGION

echo -e "\n--- LAUNCH TEMPLATES ---"
aws ec2 describe-launch-templates --region $REGION

echo -e "\n--- KEY PAIRS ---"
aws ec2 describe-key-pairs --region $REGION

echo -e "\n--- RUNNING INSTANCES ---"
aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running \
  --region $REGION

echo -e "\n--- SECURITY GROUPS ---"
aws ec2 describe-security-groups --region $REGION

echo -e "\n--- SUBNETS ---"
aws ec2 describe-subnets --region $REGION

echo -e "\n--- ROUTE TABLES ---"
aws ec2 describe-route-tables --region $REGION

echo -e "\n--- INTERNET GATEWAYS ---"
aws ec2 describe-internet-gateways --region $REGION

echo -e "\n--- NETWORK INTERFACES (ENIs) ---"
aws ec2 describe-network-interfaces --region $REGION

echo -e "\n--- VPCs ---"
aws ec2 describe-vpcs --region $REGION
