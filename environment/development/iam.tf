

data "aws_iam_policy_document" "s3_access" {

  statement {

    sid = "lists3buckets"

    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets"
    ]

    resources = [
      "*"
    ]
  }

  statement {

    sid = "readS3"

    effect = "Allow"

    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:Describe*"
    ]

    resources = [
      data.aws_s3_bucket.architek_lab_sftp_downloads.arn,
      "${data.aws_s3_bucket.architek_lab_sftp_downloads.arn}/sftp-clients/*"
    ]
  }

}


resource "aws_iam_role_policy" "sftp_policy" {
  name = "sftp_policy"
  role = aws_iam_role.transfer_family_role.id

  policy = data.aws_iam_policy_document.s3_access.json

}


data "aws_iam_policy_document" "transfer_family_trust_policy" {
  statement {
    sid = "SftpAssumerole"

    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }

}


resource "aws_iam_role" "transfer_family_role" {
  name = "transfer-family-sftp-role"

  assume_role_policy = data.aws_iam_policy_document.transfer_family_trust_policy.json

  tags = merge(
    { Name = "transfer-family-sftp-role" },
    local.common_tags
  )
}
