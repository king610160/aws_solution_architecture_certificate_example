#!/bin/bash

# 當有問題就停止
set -e

# 定義變數
NAME='king610160-test-bucket-4'

# 使用 s3api 上傳
aws s3api put-object \
    --bucket $NAME \
    --key "readme.md" \
    --body readme.md