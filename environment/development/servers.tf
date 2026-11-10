
#####################################################################
# The ami template from canonical to launch a linux-based server
#####################################################################

# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
#   }

#   owners = ["099720109477"]
# }



#####################################################################
# A backup of already launched and used
# instance to backup installations and files
#####################################################################

data "aws_ami" "architek_snapshot" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["architek-k3s-*"]
  }
}


# resource "aws_key_pair" "server_key" {
#   key_name   = "architek-server-key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCm2ED8CL/jasZll8E3C9vbVrVz+cj1c77BWDjtFtN4ZwBVjiKCa4jq56Hnra537BxoXyDUU6uh1gyMuSpTC/VHhRAR28mti0xhIPvYI8ob8JUOb+fpz+bY+UyNAcE5tjylq+Ng7JxLSSdpC1RiHSaUJuHs/Lg8Cx1BsC6Y+VyOGExD7rLtzKenHiawG6Tc8znv2WL/n4pkiRKea3V9Rj1RUzxkN9kVsxUePCqoU+vFxhMQetR1sKUioamV0K1mcOpOSz3SPrSyM5nNW7YYPXm+goYY8x/UuaeTumR+hWGX8eZEVMt9c0z73l/hpgqbSh4JZYEGxOy5g7m24D0sgKs8jDwx5MkxDYf+i4kseli2o+LNdRx6YYWO1FafUDDfUxsoPIIe05Q8bn4QtgG8KYR69onlsNUoVij38K3BmvPkrC52PI4IUMumw3dbPuoMPp29ZudioTylGdn2+k5/5NhkSJR7zHTunYrq07joxUhj/nlHyAkQwQ1gNgIF7HcJA6bZyxtdIwcra3HKB/ITvdlmG+X0n2KLDOEMxSguMX/IY50EutdU+P53Wncd/axYoo/YgimZ1FP6EIAOHr8TFSbWmR1JvZRaDXjdphChKigDUx6GO0iCJmFf8f2W6lBqVH4Pe1I962U9tvYYHonXkM3rNkWyfbrx7yzHCGg4YOPvoQ== taofeecoh@taofeecoh"

# }

# resource "aws_network_interface" "architek_server_eni" {
#   subnet_id       = aws_subnet.public_subnet_a.id
#   private_ips     = ["10.0.0.93"]
#   security_groups = [aws_security_group.private_server_sg.id]


#   tags = {
#     Name = "architek_server_primary_eni"
#   }
# }


# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "architek-ec2-profile"
#   role = aws_iam_role.ec2_role.name
# }


# resource "aws_instance" "architek_server" {

#   instance_type        = "t3.medium"
#   ami                  = data.aws_ami.architek_snapshot.id
#   iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
#   key_name             = aws_key_pair.server_key.key_name

#   primary_network_interface {
#     network_interface_id = aws_network_interface.architek_server_eni.id

#   }

#   root_block_device {
#     volume_size = 20
#     volume_type = "gp3"
#   }

#   lifecycle {
#     ignore_changes = [ami]
#   }

#   tags = merge(local.common_tags,
#     { Name = "architek-server" }
#   )
# }


#####################################################################
# OUTPUTS
#####################################################################


# output "server_ip" {
#   value = aws_instance.architek_server.public_ip
# }


# output "server_dns" {
#   value = aws_instance.architek_server.public_dns
# }

# output "server_id" {
#   value = aws_instance.architek_server.id
# }



#####################################################################
# NOTES
#####################################################################
# - The instance lifecycle block provents the AMI from being overwritten when an update is made to the resource
# aws ec2 stop-instances --instance-ids i-04ab9f827f7226022
# aws ec2 create-image --instance-id i-04ab9f827f7226022 --name architek-k3s-backup-v1
# aws ec2 describe-images --owners self --query "Images[].[Name,State]" --output table
# restart: aws ec2 start-instances --instance-ids i-04ab9f827f7226022
# terminate with terraform