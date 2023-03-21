provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "publish-s3" {
  bucket = "publish-s3"
  acl    = "public-read"

  tags = {
    Environment = "dev"
  }
}
