#!/bin/bash

# 當有問題就停止
set -e

# 定義變數
NAME='king610160-s3-bucket-for-test'
REGION='ap-northeast-1'

aws s3api list-objects \
    --bucket $NAME \
    --region $REGION 