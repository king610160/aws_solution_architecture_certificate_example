# create website 1
## create a bucket
```sh
aws s3 mb s3://cors-policy-test-2456
```

## public block
### https://docs.aws.amazon.com/cli/latest/reference/s3api/put-public-access-block.html
```sh
aws s3api put-public-access-block \
    --bucket cors-policy-test-2456 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## create bucket policy
### https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteAccessPermissionsReqd.html
```sh
aws s3api put-bucket-policy --bucket cors-policy-test-2456 --policy file://policy.json
```

## create static website
### use index.html.origin first
### https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-website.html
```sh
aws s3api put-bucket-website --bucket cors-policy-test-2456 --website-configuration file://website.json
```

## upload to bucket
```sh
aws s3 cp index.html s3://cors-policy-test-2456
```

## get website endpoint for s3
### first is ok, but second is not, maybe try
http://cors-policy-test-2456.s3-website.ap-northeast-1.amazonaws.com
http://cors-policy-test-2456.s3-website-ap-northeast-1.amazonaws.com





# create website 2
## create a bucket
```sh
aws s3 mb s3://cors-policy-test2-2334
```

## public block
### https://docs.aws.amazon.com/cli/latest/reference/s3api/put-public-access-block.html
```sh
aws s3api put-public-access-block \
    --bucket cors-policy-test2-2334 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## create bucket policy
### https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteAccessPermissionsReqd.html
```sh
aws s3api put-bucket-policy --bucket cors-policy-test2-2334 --policy file://policy2.json
```

## create static website
### https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-website.html
```sh
aws s3api put-bucket-website --bucket cors-policy-test2-2334 --website-configuration file://website.json
```

## upload to bucket
```sh
aws s3 cp index.js s3://cors-policy-test2-2334
```

## get website endpoint for s3
http://cors-policy-test2-2334.s3-website.ap-northeast-1.amazonaws.com

## fix the index.html.origin's content to index.html
## open static website 1 and check f12 console -> it should show cors error

## define cors policy
## 這裡的 cors 要設定在第 2 個網站(有 js)的那個，是收到請求的那方要比對是否同源
### https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-cors.html
```sh
aws s3api put-bucket-cors --bucket cors-policy-test2-2334 --cors-configuration file://cors.json
```

## delete bucket, object
```sh
aws s3 rm s3://cors-policy-test-2456/index.html
aws s3 rb s3://cors-policy-test-2456
aws s3 rm s3://cors-policy-test2-2334/index.js
aws s3 rb s3://cors-policy-test2-2334
```