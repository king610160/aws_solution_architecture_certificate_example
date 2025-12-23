#!/bin/bach
# we will save the ID in vpc_env.txt for later delete use, but it just for lab

set -e

# create vpc
export VPC_ID=$(aws ec2 create-vpc --cidr-block "172.1.0.0/16" \
--region ap-northeast-1 \
--tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=my-vpc-3}]' \
--query 'Vpc.VpcId' \
--output text)

echo "VPC_ID=$VPC_ID"
echo "VPC_ID=$VPC_ID" > vpc_env.txt

# turn on dns hostname
aws ec2 modify-vpc-attribute \
--vpc-id $VPC_ID \
--enable-dns-hostnames "{\"Value\":true}" \
--region ap-northeast-1

# create IGW
export IGW_ID=$(aws ec2 create-internet-gateway\
 --region ap-northeast-1\
 --query 'InternetGateway.InternetGatewayId'\
 --output text)

echo "IGW_ID=$IGW_ID"
echo "IGW_ID=$IGW_ID" >> vpc_env.txt

# attach an IGW
aws ec2 attach-internet-gateway \
--internet-gateway-id $IGW_ID \
--vpc-id $VPC_ID \
--region ap-northeast-1

# create a new subnet
export SUBNET_ID=$(aws ec2 create-subnet \
--vpc-id $VPC_ID \
--cidr-block "172.1.0.0/20" \
--region ap-northeast-1 \
--query 'Subnet.SubnetId' \
--output text)

echo "SUBNET_ID=$SUBNET_ID"
echo "SUBNET_ID=$SUBNET_ID" >> vpc_env.txt

# auto assign public IP on launch
aws ec2 modify-subnet-attribute \
--subnet-id $SUBNET_ID \
--map-public-ip-on-launch \
--region ap-northeast-1

# Get default route table
export RT_ID=$(aws ec2 describe-route-tables \
--filters "Name=vpc-id,Values=$VPC_ID" "Name=association.main,Values=true" \
--region ap-northeast-1 \
--query 'RouteTables[].RouteTableId[]' \
--output text)

echo "RT_ID=$RT_ID"
echo "RT_ID=$RT_ID" >> vpc_env.txt

# explicity associate subnet
aws ec2 associate-route-table \
--route-table-id $RT_ID \
--subnet-id $SUBNET_ID \
--region ap-northeast-1

# add route to our RT to our IGW
aws ec2 create-route \
--route-table-id $RT_ID \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id $IGW_ID