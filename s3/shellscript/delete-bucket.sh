#!/bin/bash

# 當有問題就停止
set -e

# 定義變數
NAME='king610160-test-bucket-4'
REGION='ap-northeast-1'

aws s3api delete-bucket \
    --bucket $NAME \
    --region $REGION 