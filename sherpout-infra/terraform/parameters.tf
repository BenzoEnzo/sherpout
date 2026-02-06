resource "aws_ssm_parameter" "minio_access_key" {
  name        = "/sherpout/minio/access-key"
  type        = "SecureString"
  value       = ""
  description = "MinIO access key for Sherpout"
}

resource "aws_ssm_parameter" "minio_secret_key" {
  name        = "/sherpout/minio/secret-key"
  type        = "SecureString"
  value       = ""
  description = "MinIO secret key for Sherpout"
}

resource "aws_ssm_parameter" "minio_bucket" {
  name        = "/sherpout/minio/bucket-name"
  type        = "String"
  value       = ""
  description = "MinIO bucket name"
}

resource "aws_ssm_parameter" "minio_url" {
  name        = "/sherpout/minio/url"
  type        = "String"
  value       = ""
  description = "MinIO/S3 endpoint URL"
}

resource "aws_ssm_parameter" "db_url" {
  name  = "/sherpout/db/url"
  type  = "String"
  value = ""
}

resource "aws_ssm_parameter" "db_username" {
  name  = "/sherpout/db/username"
  type  = "String"
  value = ""
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/sherpout/db/password"
  type  = "SecureString"
  value = ""
}

resource "aws_ssm_parameter" "oauth_jwk_uri" {
  name  = "/sherpout/oauth/jwk-uri"
  type  = "String"
  value = ""
}

resource "aws_ssm_parameter" "oauth_issuers" {
  name  = "/sherpout/oauth/issuers"
  type  = "String"
  value = ""
}

resource "aws_ssm_parameter" "server_port" {
  name  = "/sherpout/server/port"
  type  = "String"
  value = ""
}
