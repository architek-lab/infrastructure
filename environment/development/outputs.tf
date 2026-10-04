
output "vpc_id" {
  value = aws_vpc.architek_vpc.id
}

output "bucket_id" {
  value = data.aws_s3_bucket.architek_lab_sftp_downloads.id
}