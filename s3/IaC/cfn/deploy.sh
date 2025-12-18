#!/bin/bash

# 當有問題就停止
set -e

# 取得腳本所在的絕對路徑 (類似 playbook_dir)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 定義變數
# STACK_NAME='king610160-test-bucket-stack-4'
REGION='ap-northeast-1'
TEMPLATE_PATH="${SCRIPT_DIR}/../create-bucket.yaml"

echo "正在部署範本：${TEMPLATE_PATH}"

# 部署 CloudFormation 範本
aws cloudformation deploy \
    --template-file "$TEMPLATE_PATH" \
    --region "$REGION" \
    # --stack-name "$STACK_NAME"