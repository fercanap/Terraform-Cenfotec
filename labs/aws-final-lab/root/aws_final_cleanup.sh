#!/bin/bash
set -euo pipefail

REGION="us-west-1"

# ---------- SETTINGS ----------
LB_ARN="arn:aws:elasticloadbalancing:us-west-1:367816904393:loadbalancer/app/alb-fercanap/62fd309bce0afc25"
LISTENER_ARN="arn:aws:elasticloadbalancing:us-west-1:367816904393:listener/app/alb-fercanap/62fd309bce0afc25/858173dab1a81b7e"
TG_ARN="arn:aws:elasticloadbalancing:us-west-1:367816904393:targetgroup/tg-fercanap/d3bf806644dc7562"
LAUNCH_TEMPLATE_IDS=("lt-0a2ef29bcbefc5bc3" "lt-0a014ad6905c887c9")

# ---------- DELETE LISTENER ----------
echo "🧨 Deleting Listener..."
aws elbv2 delete-listener \
  --listener-arn "$LISTENER_ARN" \
  --region "$REGION" || echo "⚠️ Listener might already be deleted."

# ---------- DELETE TARGET GROUP ----------
echo "⏳ Waiting for Target Group to be detached from any listener..."
while aws elbv2 describe-rules --listener-arn "$LISTENER_ARN" --region "$REGION" &> /dev/null; do
    echo "🔄 Still attached... waiting 10s"
    sleep 10
done

echo "🧨 Deleting Target Group..."
aws elbv2 delete-target-group \
  --target-group-arn "$TG_ARN" \
  --region "$REGION"

# ---------- DELETE LOAD BALANCER ----------
echo "🧨 Deleting Load Balancer..."
aws elbv2 delete-load-balancer \
  --load-balancer-arn "$LB_ARN" \
  --region "$REGION"

echo "⏳ Waiting for Load Balancer to be deleted..."
while aws elbv2 describe-load-balancers --region "$REGION" \
         --query "LoadBalancers[?LoadBalancerArn=='$LB_ARN']" \
         --output text | grep -q "$LB_ARN"; do
    echo "🔄 Load Balancer still exists... waiting 15s"
    sleep 15
done

# ---------- DELETE LAUNCH TEMPLATES ----------
for LT_ID in "${LAUNCH_TEMPLATE_IDS[@]}"; do
    echo "🧨 Deleting Launch Template: $LT_ID"
    aws ec2 delete-launch-template \
      --launch-template-id "$LT_ID" \
      --region "$REGION" || echo "⚠️ Launch Template $LT_ID might already be deleted."
done

echo "✅ Cleanup complete."
