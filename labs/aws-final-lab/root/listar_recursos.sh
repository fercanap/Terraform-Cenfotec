#!/bin/bash

# Establecer región
REGION="us-west-1"
OUTPUT_DIR="./"  # Guardar en root/

echo "Listando recursos en la región $REGION..."

# 1. Target Groups
echo "🟡 Listando Target Groups..."
aws elbv2 describe-target-groups --region $REGION > ${OUTPUT_DIR}target_groups.json

# 2. Load Balancers
echo "🟡 Listando Load Balancers..."
aws elbv2 describe-load-balancers --region $REGION > ${OUTPUT_DIR}load_balancers.json

# 3. Auto Scaling Groups
echo "🟡 Listando Auto Scaling Groups..."
aws autoscaling describe-auto-scaling-groups --region $REGION > ${OUTPUT_DIR}auto_scaling_groups.json

# 4. Launch Templates
echo "🟡 Listando Launch Templates..."
aws ec2 describe-launch-templates --region $REGION > ${OUTPUT_DIR}launch_templates.json

# 5. Key Pairs
echo "🟡 Listando Key Pairs..."
aws ec2 describe-key-pairs --region $REGION > ${OUTPUT_DIR}key_pairs.json

echo "✅ Archivos generados:"
ls -1 ${OUTPUT_DIR}*.json
