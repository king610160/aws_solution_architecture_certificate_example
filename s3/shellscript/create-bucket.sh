#!/bin/bash

# 當有問題就停止
set -e

# 定義變數
NAME='king610160-test-bucket-4'
REGION='ap-northeast-1'

# 除了 us-east-1 以外，需要指定 LocationConstraint
# https://docs.aws.amazon.com/cli/latest/reference/s3api/create-bucket.html
aws s3api create-bucket \
    --bucket $NAME \
    --region $REGION \
    --create-bucket-configuration LocationConstraint=$REGION \
    --query Location \
    --output text