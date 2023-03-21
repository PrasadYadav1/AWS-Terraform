provider "aws" {
  region = "us-west-2"
}

resource "aws_cloudfront_origin_access_identity" "example" {
  comment = "Example CloudFront Origin Access Identity"
}

resource "aws_s3_bucket" "publish-s3" {
  bucket = "publish-s3"
  acl    = "public-read"

  tags = {
    Environment = "dev"
  }
}

resource "aws_cloudfront_distribution" "example" {
  origin {
    domain_name = "${aws_s3_bucket.publish-s3.bucket_regional_domain_name}"
    origin_id   = "${aws_s3_bucket.publish-s3.id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.example.cloudfront_access_identity_path}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Example CloudFront Distribution"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${aws_s3_bucket.publish-s3.id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
