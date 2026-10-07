
output "vpc_id" {
  value = aws_vpc.architek_vpc.id
}


output "public_subnet_a_id" {
  value = aws_subnet.public_subnet_a.id
}


output "public_subnet_b_id" {
  value = aws_subnet.public_subnet_b.id
}


output "bucket_id" {
  value = data.aws_s3_bucket.architek_lab_sftp_downloads.id
}
