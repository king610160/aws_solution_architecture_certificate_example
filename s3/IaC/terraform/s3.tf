resource "aws_s3_bucket" "my-bucket" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}