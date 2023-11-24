resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  lifecycle {
    prevent_destroy = false
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.clusters_name_prefix}-${var.bucket_name}-s3-bucket"
      ManagedBy = "terraform"
    }
  )
}
