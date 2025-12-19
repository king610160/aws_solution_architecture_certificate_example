terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "default" {
}

resource "aws_s3_object" "object" {
    bucket = aws_s3_bucket.default.id
    key    = "myfile.txt"
    source = "myfile.txt"

    # 讓 Terraform 監控檔案內容
    etag = filemd5("myfile.txt")
    # # 新版寫法
    # source_hash = filemd5("myfile.txt")
}
