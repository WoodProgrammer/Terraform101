resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


resource "aws_iam_instance_profile" "ec2-role" {
  name = "ec2-role"
  role = "${aws_iam_role.ec2-role.name}"
}


resource "aws_iam_role_policy" "ec2-role-policy" {
  name = "ec2-role-policy"
  role = "${aws_iam_role.ec2-role.id}"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": [
                  "s3:GetObjectVersionTorrent",
                  "s3:GetObjectAcl",
                  "s3:GetObject",
                  "s3:GetObjectTorrent",
                  "s3:GetObjectVersionTagging",
                  "s3:GetObjectVersionAcl",
                  "s3:GetObjectTagging",
                  "s3:GetObjectVersionForReplication",
                  "s3:GetObjectVersion",
                  "s3:ListMultipartUploadParts"
              ],
              "Resource": "arn:aws:s3:::*/*"
          },
          {
              "Sid": "VisualEditor1",
              "Effect": "Allow",
              "Action": [
                  "s3:GetBucketPolicyStatus",
                  "s3:GetBucketPublicAccessBlock",
                  "s3:ListBucketByTags",
                  "s3:GetLifecycleConfiguration",
                  "s3:ListBucketMultipartUploads",
                  "s3:GetBucketTagging",
                  "s3:GetInventoryConfiguration",
                  "s3:GetBucketWebsite",
                  "s3:ListBucketVersions",
                  "s3:GetBucketLogging",
                  "s3:GetAccelerateConfiguration",
                  "s3:GetBucketVersioning",
                  "s3:GetBucketAcl",
                  "s3:GetBucketNotification",
                  "s3:GetBucketPolicy",
                  "s3:GetReplicationConfiguration",
                  "s3:GetEncryptionConfiguration",
                  "s3:GetBucketRequestPayment",
                  "s3:GetBucketCORS",
                  "s3:GetAnalyticsConfiguration",
                  "s3:GetMetricsConfiguration",
                  "s3:GetBucketLocation"
              ],
              "Resource": "arn:aws:s3:::*"
          },
          {
              "Sid": "VisualEditor2",
              "Effect": "Allow",
              "Action": "s3:GetAccountPublicAccessBlock",
              "Resource": "*"
          }
      ]
}

EOF
}
