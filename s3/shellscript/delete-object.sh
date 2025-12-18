#!/bin/bash

# 當有問題就停止
set -e

# 定義變數
NAME='king610160-test-bucket-4'
QUERY='{"Objects": Contents[].{Key: Key}}'

# 1. 先列出所有檔案，並格式化成 delete-objects 要的 JSON 格式
content=$(
    aws s3api list-objects \
    --bucket $NAME \
    --query '{"Objects": Contents[].{Key: Key}}'
)

echo $content

# 2. 直接餵給 delete-objects, 會把對應的所有檔案一個個刪除
aws s3api delete-objects \
  --bucket $NAME \
  --delete "$content"