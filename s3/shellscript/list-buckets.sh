#!/bin/bash

# 當有問題就停止
set -e

# bucket 應該是沒有 region 概念的
aws s3api list-buckets 