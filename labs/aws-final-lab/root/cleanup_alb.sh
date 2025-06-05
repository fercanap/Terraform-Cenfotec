#!/bin/bash

# Parámetros
REGION="us-west-1"
TG_NAME="tg-fercanap"
LB_NAME="alb-fercanap"

echo "🔍 Obteniendo ARN del Target Group..."
TG_ARN=$(aws elbv2 describe-target-groups \
  --names "$TG_NAME" \
  --region "$REGION" \
  --query "TargetGroups[0].TargetGroupArn" \
  --output text)

echo "🔍 Obteniendo ARN del Load Balancer..."
LB_ARN=$(aws elbv2 describe-load-balancers \
  --names "$LB_NAME" \
  --region "$REGION" \
  --query "LoadBalancers[0].LoadBalancerArn" \
  --output text)

echo "🔍 Obteniendo ARN del Listener..."
LISTENER_ARN=$(aws elbv2 describe-listeners \
  --load-balancer-arn "$LB_ARN" \
  --region "$REGION" \
  --query "Listeners[0].ListenerArn" \
  --output text)

echo "🔍 Listando reglas personalizadas..."
RULE_ARNS=$(aws elbv2 describe-rules \
  --listener-arn "$LISTENER_ARN" \
  --region "$REGION" \
  --query "Rules[?IsDefault==\`false\`].RuleArn" \
  --output text)

# Paso 1: Eliminar reglas (excepto default)
if [ -n "$RULE_ARNS" ]; then
  echo "🔥 Eliminando reglas personalizadas..."
  for rule in $RULE_ARNS; do
    aws elbv2 delete-rule --rule-arn "$rule" --region "$REGION"
  done
else
  echo "✅ No hay reglas personalizadas para eliminar."
fi

# Paso 2: Eliminar listener
echo "🔥 Eliminando listener..."
aws elbv2 delete-listener \
  --listener-arn "$LISTENER_ARN" \
  --region "$REGION"

# Paso 3: Eliminar Load Balancer
echo "🔥 Eliminando Load Balancer..."
aws elbv2 delete-load-balancer \
  --load-balancer-arn "$LB_ARN" \
  --region "$REGION"

# Espera para que AWS libere el recurso
echo "⏳ Esperando 20 segundos para liberar el TG..."
sleep 20

# Paso 4: Eliminar Target Group
echo "🔥 Eliminando Target Group..."
aws elbv2 delete-target-group \
  --target-group-arn "$TG_ARN" \
  --region "$REGION"

echo "✅ Limpieza completada."
