resource "aws_s3_bucket" "bucket" {
  bucket = "crypto-s3-bucket"
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

