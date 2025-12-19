## create a bucket
```sh
aws s3 mb s3://bucket-policy-test-2456
```

## bucket policy example
https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-bucket-policies.html?icmpid=docs_amazons3_console

## create bucket policy
```sh
aws s3api put-bucket-policy --bucket bucket-policy-test-2456 --policy file://policy.json
```

## delete object and bucket
```sh
aws s3 rb s3://bucket-policy-test-2456
```