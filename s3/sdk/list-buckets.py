import boto3

# 創建一個 S3 的資源對象 (這就是從工具箱拿出的 S3 專用工具)
s3 = boto3.resource('s3')

# 列出所有的 Bucket 名稱
print("Find bucket:")
for bucket in s3.buckets.all():
    print(bucket.name)

# # 上傳一個檔案
# s3.Bucket('my-bucket-name').upload_file('hello.txt', 'hello_on_s3.txt')