variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  region = "us-east-2"
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
}

resource "aws_iam_user" "user" {
  name = "test-user"
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": [
                  "iam:ListServerCertificates",
                  "iam:ListPoliciesGrantingServiceAccess",
                  "iam:ListServiceSpecificCredentials",
                  "iam:ListMFADevices",
                  "iam:ListSigningCertificates",
                  "iam:ListVirtualMFADevices",
                  "iam:ListInstanceProfilesForRole",
                  "iam:ListSSHPublicKeys",
                  "iam:ListAttachedRolePolicies",
                  "iam:ListAttachedUserPolicies",
                  "iam:ListAttachedGroupPolicies",
                  "iam:ListRolePolicies",
                  "iam:ListAccessKeys",
                  "iam:ListPolicies",
                  "iam:ListSAMLProviders",
                  "iam:ListGroupPolicies",
                  "iam:ListEntitiesForPolicy",
                  "iam:ListRoles",
                  "iam:ListUserPolicies",
                  "iam:ListInstanceProfiles",
                  "iam:ListPolicyVersions",
                  "iam:ListOpenIDConnectProviders",
                  "iam:ListGroupsForUser",
                  "iam:ListAccountAliases",
                  "iam:ListUsers",
                  "iam:ListGroups",
                  "iam:GetLoginProfile",
                  "iam:GetAccountSummary"
              ],
              "Resource": "*"
          }
      ]
}
EOF

}

resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
