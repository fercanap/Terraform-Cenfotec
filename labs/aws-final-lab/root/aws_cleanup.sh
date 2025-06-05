#!/bin/bash

REGION="us-west-1"

echo "🔁 Deleting Auto Scaling Group..."
aws autoscaling delete-auto-scaling-group \
  --auto-scaling-group-name asg-fercanap \
  --force-delete \
  --region $REGION

echo "⏳ Waiting for Auto Scaling Group to be deleted..."
while aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names asg-fercanap \
  --region $REGION \
  --query "AutoScalingGroups[*].AutoScalingGroupName" \
  --output text | grep -q asg-fercanap; do
  echo "   ⏱️ Still exists... waiting 10s"
  sleep 10
done
echo "✅ Auto Scaling Group deleted."

echo "🧨 Deleting Launch Template..."
aws ec2 delete-launch-template \
  --launch-template-id lt-0019626ce1e23d9f6 \
  --region $REGION

# No wait available for launch template, adding a short sleep
sleep 10

echo "🌐 Deleting Load Balancer..."
aws elbv2 delete-load-balancer \
  --load-balancer-arn arn:aws:elasticloadbalancing:us-west-1:367816904393:loadbalancer/app/alb-fercanap/ad0368425942ebd9 \
  --region $REGION

echo "⏳ Waiting for Load Balancer to be deleted..."
aws elbv2 wait load-balancers-deleted \
  --load-balancer-arns arn:aws:elasticloadbalancing:us-west-1:367816904393:loadbalancer/app/alb-fercanap/ad0368425942ebd9 \
  --region $REGION

echo "🎯 Deleting Target Group..."
aws elbv2 delete-target-group \
  --target-group-arn arn:aws:elasticloadbalancing:us-west-1:367816904393:targetgroup/tg-fercanap/26090acbc5ab9a93 \
  --region $REGION

# No wait available for target group, adding a short sleep
sleep 15

echo "🔐 Deleting Key Pair..."
aws ec2 delete-key-pair \
  --key-name fercanap-key \
  --region $REGION

# Short wait to ensure stability
sleep 5

echo "🖥️ Terminating remaining EC2 Instances (if any)..."
INSTANCE_IDS=$(aws ec2 describe-instances --region $REGION --query "Reservations[*].Instances[*].InstanceId" --output text)

if [ -n "$INSTANCE_IDS" ]; then
  for ID in $INSTANCE_IDS; do
    echo "🚨 Terminating instance: $ID"
    aws ec2 terminate-instances --instance-ids $ID --region $REGION
    echo "⏳ Waiting for instance $ID to terminate..."
    aws ec2 wait instance-terminated --instance-ids $ID --region $REGION
  done
else
  echo "✅ No instances found to terminate."
fi

echo "🧹 Cleanup completed successfully. You may now re-run Terraform."
