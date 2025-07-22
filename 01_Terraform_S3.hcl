# Vulnérabilités : A01 (Broken Access Control), A05 (Security Misconfiguration)
resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "my-public-data-bucket"
}

resource "aws_s3_bucket_public_access_block" "vulnerable_bucket_pab" {
  bucket = aws_s3_bucket.vulnerable_bucket.id
  
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "vulnerable_bucket_acl" {
  bucket = aws_s3_bucket.vulnerable_bucket.id
  acl    = "public-read-write"  # Critique : accès public en écriture
}

# Pas de chiffrement activé
resource "aws_s3_bucket_server_side_encryption_configuration" "vulnerable_encryption" {
  bucket = aws_s3_bucket.vulnerable_bucket.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false  # Pas d'optimisation de clé
  }
}