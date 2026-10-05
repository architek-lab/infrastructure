

resource "aws_security_group" "sftp_sg" {
  name        = "sftp-sg"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.architek_vpc.id

  tags = merge(local.common_tags,
    { Name = "sftp-sg" }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sftp_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = local.common_tags
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4_traffic" {
  security_group_id = aws_security_group.sftp_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = local.common_tags
}
