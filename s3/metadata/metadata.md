## create a bucket
aws s3 mb s3://metadata-test-123321

## create a new file
echo "hello java" > myfile.txt

## upload file with metadata
### metadata need to be key-value pair, seperate by ","
aws s3api put-object --bucket metadata-test-123321 --key myfile.txt --body myfile.txt --metadata user=May,version=2

## get the object
aws s3api head-object  --bucket metadata-test-123321 --key myfile.txt

## delete object and bucket
aws s3 rm s3://metadata-test-123321/myfile.txt
aws s3 rb s3://metadata-test-123321