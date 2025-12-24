
## check which vpc need to use
```sh
aws ec2 describe-vpcs \
--query 'Vpcs[].{VpcId: VpcId, Name: Tags[?Key==`Name`].Value | [0]}' \
--output table
```

## check subnet id
```sh
aws ec2 describe-subnets \
--filters "Name=vpc-id,Values=vpc-00a1707be07d845aa" \
--query 'Subnets[].{SubnetId: SubnetId, Name: Tags[?Key==`Name`].Value | [0], CIDR: CidrBlock}' \
--output table
```

## create nacl rule
```sh
aws ec2 create-network-acl --vpc-id vpc-00a1707be07d845aa
```

## get amazon linux2 ami image 
## use describe-image need to filter many image, it just slow
```sh
aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 \
--region ap-northeast-1 \
--query 'Parameters[0].Value' \
--output text
```

## launch an ec2 with that image id
## use cloudformation's template function

## get nacl id
```sh
aws ec2 describe-network-acls \
--filters "Name=association.subnet-id,Values=subnet-082b505bb9c9f3a6f" \
--query "NetworkAcls[0].NetworkAclId" \
--output text
```

## create nacl rule
## a simple rule number is 100, lower rule number will apply first
## this rule is block particular ip
```sh
aws ec2 create-network-acl-entry \
    --network-acl-id acl-xxxxxxxxxxxx \
    --ingress \
    --rule-number 90 \
    --protocol -1 \
    --port-range From=0,To=65535 \
    --cidr-block 203.0.113.5/32 \
    --rule-action deny \
    --region ap-northeast-1
```