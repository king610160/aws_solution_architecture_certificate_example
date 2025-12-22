resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket-34543"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}