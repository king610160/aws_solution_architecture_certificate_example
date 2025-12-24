#!/bin/bash

set -e

NAME='king610160-test-bucket-11'
REGION='ap-northeast-1'
MY_POLICY="my-policy"
USER="Alice"

# create s3 bucket
aws s3api create-bucket \
    --bucket $NAME \
    --region $REGION \
    --create-bucket-configuration LocationConstraint=$REGION \
    --query Location \
    --output text
echo "Create bucket: $NAME"

# create user
aws iam create-user \
    --user-name $USER
echo "Create user: $USER"

# get user arn
USER_ARN=$(aws iam get-user \
    --user-name $USER \
    --query 'User.Arn' \
    --no-cli-pager \
    --output text)

# check have no permission to s3
aws iam simulate-principal-policy \
    --policy-source-arn $USER_ARN \
    --action-names s3:ListBucket \
    --resource-arns arn:aws:s3:::$NAME \
    --no-cli-pager \
    --query "EvaluationResults[].EvalDecision" \
    --output text | grep "implicitDeny"

# transform yaml to json
yq -o json policy.yaml > policy.json

# create iam policy
aws iam create-policy \
    --policy-name $MY_POLICY \
    --policy-document file://policy.json \
    --no-cli-pager \


POLICY_ARN=$(aws iam list-policies \
    --scope Local \
    --query "Policies[?PolicyName=='$MY_POLICY'].Arn" \
    --no-cli-pager \
    --output text)

echo "ARN: $POLICY_ARN"

# attach policy to user
aws iam attach-user-policy \
    --policy-arn $POLICY_ARN \
    --user-name $USER
echo "Attach policy"

# check have no permission to s3, it should work
aws iam simulate-principal-policy \
    --policy-source-arn $USER_ARN \
    --action-names s3:ListBucket \
    --resource-arns arn:aws:s3:::$NAME \
    --no-cli-pager \
    --query "EvaluationResults[].EvalDecision" \
    --output text | grep "implicitDeny"