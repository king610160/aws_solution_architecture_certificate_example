import boto3
import os

# 1. 定義類似 Ansible 'playbook_dir' 的變數
# 取得目前這個 .py 檔案所在的絕對路徑目錄
current_script_dir = os.path.dirname(os.path.abspath(__file__))

def upload_directory_to_s3(relative_local_dir, bucket_name, s3_prefix=""):
    """
    :param relative_local_dir: 相對於腳本位置的資料夾路徑 (例如 '../test_file')
    """
    s3_client = boto3.client('s3')

    # 2. 組合出絕對路徑 (解決路徑找不到的問題)
    absolute_local_path = os.path.abspath(os.path.join(current_script_dir, relative_local_dir))
    
    # # 除錯用
    # print(f"解析後的絕對路徑為: {absolute_local_path}")

    if not os.path.exists(absolute_local_path):
        print("錯誤：找不到該路徑，請檢查資料夾是否存在。")
        return

    # 遞迴走訪
    for root, dirs, files in os.walk(absolute_local_path):
        for filename in files:
            local_file_path = os.path.join(root, filename)
            
            # 計算 S3 上的 Key (保持資料夾結構)
            relative_path = os.path.relpath(local_file_path, absolute_local_path)
            s3_key = os.path.join(s3_prefix, relative_path).replace("\\", "/")

            try:
                s3_client.upload_file(local_file_path, bucket_name, s3_key)
                print(f"成功上傳: {s3_key}")
            except Exception as e:
                print(f"上傳 {s3_key} 失敗: {e}")

# 執行
if __name__ == "__main__":
    BUCKET = "king610160-test-bucket-4"
    # 對應你的 Ansible vars: local_dir: "{{ playbook_dir }}/../test_file"
    RELATIVE_DIR = "../test_file" 
    # 對應你的 Ansible vars: remote_path: "test_file"
    REMOTE_PREFIX = "test_file"

    upload_directory_to_s3(RELATIVE_DIR, BUCKET, REMOTE_PREFIX)