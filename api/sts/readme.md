## URL
https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-guide.html
find template format, it will have example inside

# this is for temperary credential for IAM role, this just like k8s sa
## create a user with no permission
we need to create a new user with no permission and generate out access key
```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user
aws configure
```

## test who you are
```sh
aws sts get-caller-identity
```

## edit aws credential file
set sts as a user in aws credential file
```sh
vi ~/.aws/credentials
```

## make sure user sts have not access to s3
```sh
aws s3 ls --profile sts
```

## create a role
we need to create a role that will access a new resource
this role assume a user with a role, which can do the action, with the policy
```sh
chmod u+x ./bin/deploy.sh
./bin/deploy.sh
```

## let new user have previlege to assume role
```sh
aws iam put-user-policy \
    --user-name sts-machine-user \
    --policy-name StsAssumePolicy \
    --policy-document file://policy.json
```

## produce sts token, this token will expire in minutes to hours
```sh
aws sts assume-role \
    --role-arn arn:aws:iam::<user_id>:role/my-sts-fun-stack-StsRole-tS9XhwFQF4F9 \
    --role-session-name s3-sts-fun \
    --profile sts
```

## get the token, access key, secret key
set them in the aws credential file

## check credential
```sh
aws sts get-caller-identity --profile assumed
```

## check particular bucket
```sh
aws s3 ls --profile assumed
aws s3 ls s3://sts-fun-ab-223 --profile assumed
```

## delete everything
```sh
aws iam delete-user-policy --user-name sts-machine-user --policy-name StsAssumePolicy
aws iam delete-access-key --access-key-id AKIA4MTWJY5E222BCMU7 --user-name sts-machine-user
aws iam delete-user --user-name sts-machine-user

```