## create a bucket
```sh
aws s3 mb s3://encryption-test-245
```

## upload to bucket with sse-s3 (default encryption)
```sh
echo "hello word" > test.txt
aws s3 cp test.txt s3://encryption-test-245
```

## upload file with kms encryption
```sh
aws s3api put-bucket-encryption \
    --bucket encryption-test-245 \
    --key test.txt \
    --body test.txt \
    --server-side-encryption-configuration aws:kms \
    --ssekms-key-id <related_id>
```

## check kms key
```sh
aws kms list-keys
```

## s3 use kms to encrypt
```sh
aws s3 cp test.txt s3://encryption-test-245 \
    --sse aws:kms
```

## remove bucket, file
```sh
aws s3 rm s3://encryption-test-245/test.txt
aws s3 rb s3://encryption-test-245
```


### Tip
If you want use aws managed, set s3 encryption to what you want as default setting, then create bucket and upload the file, AWS will auto create the related key, which you can use in other project.