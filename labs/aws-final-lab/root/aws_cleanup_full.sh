#!/bin/bash

# Define resource identifiers (replace as needed)
TG_NAME="tg-fercanap"
LB_NAME="alb-fercanap"
ASG_NAME="asg-fercanap"
LT_NAME="lt-fercanap"
KEY_NAME="fercanap-key"
REGION="us-west-1"

echo "Starting AWS Cleanup Script..."

# Function to delete Auto Scaling Group
delete_asg() {
  asg=$(aws autoscaling describe-auto-scaling-groups --region "$REGION" --query "AutoScalingGroups[?AutoScalingGroupName=='$ASG_NAME'].[AutoScalingGroupName]" --output text)
  if [[ $asg == "$ASG_NAME" ]]; then
    echo "Deleting Auto Scaling Group: $ASG_NAME"
    aws autoscaling update-auto-scaling-group --auto-scaling-group-name "$ASG_NAME" --min-size 0 --max-size 0 --desired-capacity 0 --region "$REGION"
    aws autoscaling delete-auto-scaling-group --auto-scaling-group-name "$ASG_NAME" --force-delete --region "$REGION"
    echo "Waiting 20 seconds for ASG deletion..."
    sleep 20
  else
    echo "No ASG found: $ASG_NAME"
  fi
}

# Function to delete Launch Template
delete_lt() {
  lt=$(aws ec2 describe-launch-templates --region "$REGION" --query "LaunchTemplates[?LaunchTemplateName=='$LT_NAME'].[LaunchTemplateId]" --output text)
  if [[ -n $lt ]]; then
    echo "Deleting Launch Template: $LT_NAME"
    aws ec2 delete-launch-template --launch-template-id "$lt" --region "$REGION"
    sleep 5
  else
    echo "No Launch Template found: $LT_NAME"
  fi
}

# Function to delete Load Balancer
delete_lb() {
  lb_arn=$(aws elbv2 describe-load-balancers --region "$REGION" --query "LoadBalancers[?LoadBalancerName=='$LB_NAME'].LoadBalancerArn" --output text)
  if [[ -n $lb_arn ]]; then
    echo "Deleting Load Balancer: $LB_NAME"
    aws elbv2 delete-load-balancer --load-balancer-arn "$lb_arn" --region "$REGION"
    echo "Waiting 30 seconds for LB deletion..."
    sleep 30
  else
    echo "No Load Balancer found: $LB_NAME"
  fi
}

# Function to delete Target Group
delete_tg() {
  tg_arn=$(aws elbv2 describe-target-groups --region "$REGION" --query "TargetGroups[?TargetGroupName=='$TG_NAME'].TargetGroupArn" --output text)
  if [[ -n $tg_arn ]]; then
    echo "Deleting Target Group: $TG_NAME"
    aws elbv2 delete-target-group --target-group-arn "$tg_arn" --region "$REGION"
    sleep 10
  else
    echo "No Target Group found: $TG_NAME"
  fi
}

# Function to delete EC2 instances
delete_instances() {
  instance_ids=$(aws ec2 describe-instances --filters Name=tag:Name,Values="bastion-fercanap" --region "$REGION" --query "Reservations[*].Instances[*].InstanceId" --output text)
  if [[ -n $instance_ids ]]; then
    echo "Terminating EC2 instances: $instance_ids"
    aws ec2 terminate-instances --instance-ids $instance_ids --region "$REGION"
    echo "Waiting for EC2 instances to terminate..."
    aws ec2 wait instance-terminated --instance-ids $instance_ids --region "$REGION"
  else
    echo "No EC2 instances found with tag Name=bastion-fercanap"
  fi
}

# Function to delete Key Pair
delete_key() {
  exists=$(aws ec2 describe-key-pairs --region "$REGION" --query "KeyPairs[?KeyName=='$KEY_NAME'].KeyName" --output text)
  if [[ $exists == "$KEY_NAME" ]]; then
    echo "Deleting Key Pair: $KEY_NAME"
    aws ec2 delete-key-pair --key-name "$KEY_NAME" --region "$REGION"
    sleep 5
  else
    echo "No Key Pair found: $KEY_NAME"
  fi
}

# Execute deletions
delete_asg
delete_lt
delete_lb
delete_tg
delete_instances
delete_key

echo "Running 'terraform destroy -auto-approve'..."
terraform destroy -auto-approve

echo "Cleanup Completed!"
