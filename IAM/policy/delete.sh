#!/bin/bash

NAME='king610160-test-bucket-11'
REGION='ap-northeast-1'
MY_POLICY="my-policy"
USER="Alice"

POLICY_ARN=$(aws iam list-policies \
    --scope Local \
    --query "Policies[?PolicyName=='$MY_POLICY'].Arn" \
    --output text)

echo "ARN: $POLICY_ARN"

# detach policy from user
aws iam detach-user-policy \
    --user-name $USER \
    --policy-arn $POLICY_ARN
echo "Detach policy"

# delete policy
aws iam delete-policy \
    --policy-arn $POLICY_ARN
echo "Delete policy"

# delete user
aws iam delete-user \
    --user-name $USER
echo "Delete user"

aws s3api delete-bucket \
    --bucket $NAME \
    --region $REGION 
echo "Delete bucket"