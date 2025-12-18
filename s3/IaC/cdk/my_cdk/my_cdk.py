from aws_cdk import (
    Stack,
    aws_s3 as s3,
    RemovalPolicy,
)
from constructs import Construct

class MyCdkAppStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # 這裡就是用 Python 定義一個 S3 Bucket
        s3.Bucket(self, "MyFirstCDKBucket",
            # SAA 考試重點 1: Bucket 名稱 (如果不指定，CDK 會自動幫你生成一個全球唯一的)
            bucket_name="king610160-cdk-test-bucket", 
            
            # SAA 考試重點 2: 版本控制 (Versioning)
            versioned=True,
            
            # SAA 考試重點 3: 加密 (預設使用 S3 Managed Key)
            encryption=s3.BucketEncryption.S3_MANAGED,
            
            # 方便測試：當刪除 Stack 時，連同 Bucket 一起刪除 (預設是 RETAIN 保留)
            removal_policy=RemovalPolicy.DESTROY,
            
            # 方便測試：如果 Bucket 裡面有檔案，也強制刪除 (否則會報錯)
            auto_delete_objects=True
        )