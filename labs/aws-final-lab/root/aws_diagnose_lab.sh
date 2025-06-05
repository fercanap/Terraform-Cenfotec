#!/bin/bash

REGION="us-west-1"
output_file="diagnostico_output.txt"

echo "===== AWS Resource Diagnosis - Region: $REGION =====" > "$output_file"

echo -e "\n--- EC2 Instances ---" >> "$output_file"
aws ec2 describe-instances \
  --region $REGION \
  --query 'Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,Type:InstanceType,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
  --output table >> "$output_file"

echo -e "\n--- Auto Scaling Groups ---" >> "$output_file"
aws autoscaling describe-auto-scaling-groups \
  --region $REGION \
  --query 'AutoScalingGroups[*].{Name:AutoScalingGroupName,Min:MinSize,Max:MaxSize,Desired:DesiredCapacity,Instances:Instances[*].InstanceId}' \
  --output table >> "$output_file"

echo -e "\n--- Launch Templates ---" >> "$output_file"
aws ec2 describe-launch-templates \
  --region $REGION \
  --query 'LaunchTemplates[*].{Name:LaunchTemplateName,ID:LaunchTemplateId}' \
  --output table >> "$output_file"

echo -e "\n--- Load Balancers ---" >> "$output_file"
aws elbv2 describe-load-balancers \
  --region $REGION \
  --query 'LoadBalancers[*].{Name:LoadBalancerName,DNS:DNSName,State:State.Code,Type:Type}' \
  --output table >> "$output_file"

# Buscar ARN del ALB que contenga 'alb-fercanap'
load_balancer_arn=$(aws elbv2 describe-load-balancers \
  --region $REGION \
  --query "LoadBalancers[?contains(DNSName, 'alb-fercanap')].LoadBalancerArn" \
  --output text)

echo -e "\n--- LISTENERS for alb-fercanap ---" >> "$output_file"
if [[ -n "$load_balancer_arn" ]]; then
  aws elbv2 describe-listeners \
    --load-balancer-arn "$load_balancer_arn" \
    --region $REGION >> "$output_file"
else
  echo "No Load Balancer found for 'alb-fercanap'" >> "$output_file"
fi

echo -e "\n--- Target Groups ---" >> "$output_file"
aws elbv2 describe-target-groups \
  --region $REGION \
  --query 'TargetGroups[*].{Name:TargetGroupName,Port:Port,Protocol:Protocol,VPC:VpcId}' \
  --output table >> "$output_file"

echo -e "\n--- Key Pairs ---" >> "$output_file"
aws ec2 describe-key-pairs \
  --region $REGION \
  --query 'KeyPairs[*].{Name:KeyName,Type:KeyType}' \
  --output table >> "$output_file"

echo -e "\n--- VPCs ---" >> "$output_file"
aws ec2 describe-vpcs \
  --region $REGION \
  --query 'Vpcs[*].{VPC:VpcId,CIDR:CidrBlock,State:State}' \
  --output table >> "$output_file"

echo -e "\n--- Subnets ---" >> "$output_file"
aws ec2 describe-subnets \
  --region $REGION \
  --query 'Subnets[*].{Subnet:SubnetId,CIDR:CidrBlock,AZ:AvailabilityZone,VPC:VpcId}' \
  --output table >> "$output_file"

echo -e "\n--- Internet Gateways ---" >> "$output_file"
aws ec2 describe-internet-gateways \
  --region $REGION \
  --query 'InternetGateways[*].{IGW:InternetGatewayId,Attachments:Attachments[*].VpcId}' \
  --output table >> "$output_file"

echo -e "\n--- Route Tables ---" >> "$output_file"
aws ec2 describe-route-tables \
  --region $REGION \
  --query 'RouteTables[*].{ID:RouteTableId,VPC:VpcId,Routes:Routes[*].DestinationCidrBlock}' \
  --output table >> "$output_file"

echo -e "\n--- NAT Gateways ---" >> "$output_file"
aws ec2 describe-nat-gateways \
  --region $REGION \
  --query 'NatGateways[*].{ID:NatGatewayId,State:State,VPC:VpcId,Subnet:SubnetId}' \
  --output table >> "$output_file"

echo -e "\n--- Security Groups ---" >> "$output_file"
aws ec2 describe-security-groups \
  --region $REGION \
  --query 'SecurityGroups[*].{ID:GroupId,Name:GroupName,VPC:VpcId}' \
  --output table >> "$output_file"

echo -e "\n===== Diagnosis Complete =====" >> "$output_file"

echo "Diagnóstico guardado en: $output_file"
