import boto3
from botocore.exceptions import ClientError

def create_s3_bucket(bucket_name, region=None):
    """
    使用 boto3 建立一個 S3 Bucket
    """
    try:
        if region is None:
            # 如果沒指定區域，預設會在 us-east-1 (N. Virginia)
            s3_client = boto3.client('s3')
            s3_client.create_bucket(Bucket=bucket_name)
        else:
            # 如果在其他區域，需要指定 LocationConstraint
            s3_client = boto3.client('s3', region_name=region)
            location = {'LocationConstraint': region}
            s3_client.create_bucket(
                Bucket=bucket_name,
                CreateBucketConfiguration=location
            )
        print(f"成功建立 Bucket: {bucket_name}")
        
    except ClientError as e:
        print(f"建立失敗: {e}")
        return False
    return True

# 執行測試
create_s3_bucket('king610160-test-bucket-4', region='ap-northeast-1')