#!/bin/bash

# 當有問題就停止
set -e

# 定義變數
NAME='king610160-test-bucket-4'
FILE='test_file'

# 同步資料夾至 s3 的指定 bucket
aws s3 sync ./s3/${FILE} s3://${NAME}/${FILE}