#!/bin/bash

# 當有問題就停止
set -e

# 取得腳本所在的絕對路徑 (類似 playbook_dir)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 定義變數
STACK_NAME='my-stack'
REGION='ap-northeast-1'
TEMPLATE_PATH="${SCRIPT_DIR}/../create-bucket.yaml"

# 甚至可以動態生成名稱
BUCKET_NAME="king610160-dynamic-name-$(date +%s)"

echo "正在部署範本：${TEMPLATE_PATH}"

# 這裡的 MyBucketName 參數會傳給 CloudFormation 範本
aws cloudformation deploy \
    --template-file "$TEMPLATE_PATH" \
    --region "$REGION" \
    --stack-name "$STACK_NAME" \
    --parameter-overrides MyBucketName="$BUCKET_NAME"