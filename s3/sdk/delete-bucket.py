import boto3
from botocore.exceptions import ClientError

def delete_all_objects_and_bucket(bucket_name):
    # 使用 resource 層級的 API，處理大量物件時比較方便
    s3 = boto3.resource('s3')
    bucket = s3.Bucket(bucket_name)

    try:
        print(f"正在清空並刪除 Bucket: {bucket_name}...")
        
        # 1. 刪除所有物件（包含所有版本，如果有的話）
        # 注意：這是針對沒有開啟「版本控制」的簡單寫法
        bucket.objects.all().delete()
        
        # 2. 刪除 Bucket 本身
        bucket.delete()
        
        print(f"Bucket {bucket_name} 已成功刪除！")
        
    except ClientError as e:
        print(f"發生錯誤: {e}")

# 執行測試
delete_all_objects_and_bucket('king610160-test-bucket-4')