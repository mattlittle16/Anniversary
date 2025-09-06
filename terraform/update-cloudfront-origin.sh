# Script to update the fargate subdomain with new Fargate task IP
# This keeps CloudFront connected to the running Fargate task via DNS

# Get the running Fargate task's public IP
TASK_ARN=$(aws ecs list-tasks --cluster anniversary-prod --service-name anniversary-prod --query 'taskArns[0]' --output text)

if [ "$TASK_ARN" = "None" ] || [ -z "$TASK_ARN" ]; then
    echo "No running task found"
    exit 1
fi

TASK_IP=$(aws ecs describe-tasks --cluster anniversary-prod --tasks $TASK_ARN --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value' --output text | xargs -I {} aws ec2 describe-network-interfaces --network-interface-ids {} --query 'NetworkInterfaces[0].Association.PublicIp' --output text)

if [ -z "$TASK_IP" ]; then
    echo "Could not retrieve task IP"
    exit 1
fi

echo "Found Fargate task IP: $TASK_IP"

# Update the fargate subdomain A record to point to the new IP
aws route53 change-resource-record-sets --hosted-zone-id Z2XOL1PMUX83NQ --change-batch "{
  \"Changes\": [
    {
      \"Action\": \"UPSERT\",
      \"ResourceRecordSet\": {
        \"Name\": \"fargate.mattandbrittney.com\",
        \"Type\": \"A\",
        \"TTL\": 300,
        \"ResourceRecords\": [
          {
            \"Value\": \"$TASK_IP\"
          }
        ]
      }
    }
  ]
}" --no-cli-pager

echo "Updated fargate.mattandbrittney.com to point to: $TASK_IP"
echo "CloudFront will automatically use the new IP via DNS (may take 5-10 minutes to propagate)"

# Cleanup any temporary files if they exist
rm -f distribution-config.json updated-config.json fargate-config.json test-config.json 2>/dev/null || true
