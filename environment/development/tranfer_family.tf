
# resource "aws_eip" "sftp_public_subnet_a" {
#   domain = "vpc"
#   tags   = local.common_tags
# }

# resource "aws_eip" "sftp_public_subnet_b" {
#   domain = "vpc"
#   tags   = local.common_tags
# }


# # TRANSFER FAMILY SERVER
# resource "aws_transfer_server" "architek_sftp" {
#   endpoint_type = "VPC"


#   endpoint_details {
#     address_allocation_ids = [aws_eip.sftp_public_subnet_a.id, aws_eip.sftp_public_subnet_b.id]
#     vpc_id                 = aws_vpc.architek_vpc.id
#     subnet_ids             = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
#     security_group_ids     = [aws_security_group.sftp_sg.id]

#   }

#   protocols = ["SFTP"]

#   tags = merge(local.common_tags,
#     { Name = "architek-sftp" }
#   )
# }


# # TRANSFER FAMILY USER
# resource "aws_transfer_user" "nordtextil" {
#   server_id  = aws_transfer_server.architek_sftp.id
#   user_name  = "nordtextil"
#   role       = aws_iam_role.transfer_family_role.arn
#   depends_on = [aws_iam_role_policy.sftp_policy]
  
#   home_directory_type = "LOGICAL"
#   home_directory_mappings {
#     entry  = "/"
#     target = "/${data.aws_s3_bucket.architek_lab_sftp_downloads.id}/sftp-clients"
#  

# }

# resource "aws_transfer_ssh_key" "nordtextil" {
#   server_id = aws_transfer_server.architek_sftp.id
#   user_name = aws_transfer_user.nordtextil.user_name
#   body      = trimspace("ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJHzXuOxuUkJ6c5ux/Ty0gEcmlWY0ZMOqqV/Bfvg6pcs taofeecoh@taofeecoh")
# }

# output "sftp_endpoint" {
#   value       = aws_transfer_server.architek_sftp.endpoint
#   description = "The public endpoint URL of your production SFTP server"
# }
