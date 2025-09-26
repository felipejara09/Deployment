# aws/init/01-create-sqs-and-dynamo.sh
#!/usr/bin/env bash
set -euo pipefail

# Cola SQS
awslocal sqs create-queue --queue-name status-changed-queue || true

awslocal dynamodb create-table \
  --table-name report_metrics \
  --attribute-definitions AttributeName=metric,AttributeType=S \
  --key-schema AttributeName=metric,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

awslocal dynamodb create-table \
  --table-name approved_seen \
  --attribute-definitions AttributeName=applicationId,AttributeType=S \
  --key-schema AttributeName=applicationId,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

# fila inicial en metrics
awslocal dynamodb put-item --table-name report_metrics \
  --item '{"metric":{"S":"approved_total"},"value":{"N":"0"}}'
