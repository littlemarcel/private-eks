resource "aws_ecr_registry_policy" "allow_pull_through" {
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PullThroughCachePublicECR"
        Effect    = "Allow"
        Principal = "*"
        Action    = "ecr-public:GetRepositoryCatalogData"
        Resource  = "*"
        Condition = {
          StringLike = {
            "ecr-public:SyncPullthroughRepositoryUri" = "public.ecr.aws/*"
          }
        }
      },
      {
        Sid       = "PullThroughCacheK8s"
        Effect    = "Allow"
        Principal = "*"
        Action    = "ecr-public:SyncRepositoryCatalogData"
        Resource  = "*"
        Condition = {
          StringLike = {
            "ecr-public:SyncPullthroughRepositoryUri" = "registry.k8s.io/*"
          }
        }
      },
      {
        Sid       = "PullThroughCacheQuay"
        Effect    = "Allow"
        Principal = "*"
        Action    = "ecr-public:SyncRepositoryCatalogData"
        Resource  = "*"
        Condition = {
          StringLike = {
            "ecr-public:SyncPullthroughRepositoryUri" = "quay.io/*"
          }
        }
      }
    ]
  })
}

resource "aws_ecr_pull_through_cache_rule" "pull_through_rule_public_aws" {
  ecr_repository_prefix = "ecr-public"
  upstream_registry_url = "public.ecr.aws"
}

resource "aws_ecr_pull_through_cache_rule" "pull_through_rule_quay" {
  ecr_repository_prefix = "quay"
  upstream_registry_url = "quay.io"
}

resource "aws_ecr_pull_through_cache_rule" "k8s" {
  ecr_repository_prefix = "k8s"
  upstream_registry_url = "registry.k8s.io"
}
