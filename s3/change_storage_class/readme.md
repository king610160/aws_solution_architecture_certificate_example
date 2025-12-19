## create a bucket
```sh
aws s3 mb s3://change-storage-test-123321
```

## create a new file
```sh
echo "hello java" > myfile.txt
```

## upload file with change
```sh
aws s3 cp myfile.txt s3://change-storage-test-123321 --storage-class STANDARD_IA
```

## get the object
```sh
aws s3api head-object  --bucket change-storage-test-123321 --key myfile.txt
```

## delete object and bucket
```sh
aws s3 rm s3://change-storage-test-123321/myfile.txt
aws s3 rb s3://change-storage-test-123321
```