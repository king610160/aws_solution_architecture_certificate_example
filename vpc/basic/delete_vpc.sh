#!/bin/bash

set -e

# check file exist,or it will not execute
if [ ! -f ./vpc_env.txt ]; then
    echo "error：find no vpc_env.txt, cannot get resource ID"
    exit 1
fi

source ./vpc_env.txt
echo "Prepare delete VPC: $VPC_ID, IGW: $IGW_ID, SUBNET: $SUBNET_ID, RT: $RT_ID"

region="ap-northeast-1"

# Delete Subnet
if [ ! -z "$SUBNET_ID" ]; then
    echo "Deleting Subnet: $SUBNET_ID"
    aws ec2 delete-subnet --subnet-id $SUBNET_ID --region $region
fi

# # Delete self-defined Route Table
# # 注意：VPC 內建的 Main Route Table 會隨 VPC 刪除，只需刪除你自己 create 的
# # 若是 default VPC 則不需刪除 Route Table
# if [ ! -z "$RT_ID" ]; then
#     echo "Deleting Route Table: $RT_ID"
#     aws ec2 delete-route-table --route-table-id $RT_ID --region $region
# fi

# Deattach and delete IGW
if [ ! -z "$IGW_ID" ]; then
    echo "Deattach and delete IGW: $IGW_ID"
    aws ec2 detach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID --region $region
    aws ec2 delete-internet-gateway --internet-gateway-id $IGW_ID --region $region
fi

# Delete VPC
if [ ! -z "$VPC_ID" ]; then
    echo "Deleting VPC: $VPC_ID"
    aws ec2 delete-vpc --vpc-id $VPC_ID --region $region
fi

# delete vpc_env.txt
rm -rf vpc_env.txt
echo "All resources deleted and vpc_env.txt removed."