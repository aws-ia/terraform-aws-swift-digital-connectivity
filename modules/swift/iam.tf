// AMH

module "amh_functional_role" {
  source = "../iam/role"

  name = "amh-functional-role"
  trusted_aws_services = [
    "ec2.amazonaws.com"
  ]
  create_instance_profile = true
  attach_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  ]
  policy = jsonencode(
    {
      "Version" : "2012-10-17"
      "Statement" : [
        {
          "Action" : "s3:GetObject",
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:s3:::aws-quickstart-eu-west-1/*",
            "arn:aws:s3:::amazoncloudwatch-agent-eu-west-1/*",
            "arn:aws:s3:::aws-ssm-eu-west-1/*",
            "arn:aws:s3:::aws-windows-downloads-eu-west-1/*",
            "arn:aws:s3:::amazon-ssm-eu-west-1/*",
            "arn:aws:s3:::amazon-ssm-packages-eu-west-1/*",
            "arn:aws:s3:::eu-west-1-birdwatcher-prod/*",
            "arn:aws:s3:::aws-ssm-distributor-file-eu-west-1/*",
            "arn:aws:s3:::patch-baseline-snapshot-eu-west-1/*"
          ],
          "Sid" : "SSMPermissionsPolicyForSSMandCWAgent"
        },
        {
          "Action" : [
            "cloudwatch:PutMetricData",
            "ec2:DescribeVolumes",
            "ec2:DescribeTags",
            "logs:PutLogEvents",
            "logs:DescribeLogStreams",
            "logs:DescribeLogGroups",
            "logs:CreateLogStream",
            "logs:CreateLogGroup"
          ],
          "Effect" : "Allow",
          "Resource" : "*",
          "Sid" : "CWAgentPermissions"
        },
        {
          "Action" : "ssm:GetParameter",
          "Effect" : "Allow",
          "Resource" : "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*",
          "Sid" : "SSMParameterStorePermissions"
        }
      ],
    }
  )
}

// SWFIT instance operator role
/*
{
  "Resources": {
    "SWIFTInstanceOperatorRoleEDD819B7": {
      "Type": "AWS::IAM::Role",
      "Properties": {
        "AssumeRolePolicyDocument": {
          "Statement": [
            {
              "Action": "sts:AssumeRole",
              "Condition": {
                "Bool": {
                  "aws:MultiFactorAuthPresent": "true"
                }
              },
              "Effect": "Allow",
              "Principal": {
                "AWS": {
                  "Fn::Join": [
                    "",
                    [
                      "arn:",
                      {
                        "Ref": "AWS::Partition"
                      },
                      ":iam::290945594156:root"
                    ]
                  ]
                }
              }
            }
          ],
          "Version": "2012-10-17"
        },
        "RoleName": "SWIFTInstanceOperatorRole"
      },
      "Metadata": {
        "aws:cdk:path": "SWIFTMain-eu-west-1/IAMRole/SWIFTInstanceOperatorRole/Resource"
      }
    },
    "SSMInstanceAccessPolicy01BB5F8E": {
      "Type": "AWS::IAM::Policy",
      "Properties": {
        "PolicyDocument": {
          "Statement": [
            {
              "Action": [
                "ssm:StartSession",
                "ssm:SendCommand"
              ],
              "Condition": {
                "BoolIfExists": {
                  "ssm:SessionDocumentAccessCheck": "true"
                }
              },
              "Effect": "Allow",
              "Resource": [
                "arn:aws:ssm:eu-west-1:290945594156:document/SSM-SessionManagerRunShell",
                {
                  "Fn::Join": [
                    "",
                    [
                      "arn:aws:ec2:eu-west-1:290945594156:instance/",
                      {
                        "Ref": "referencetoSWIFTMaineuwest1AMH1NestedStackAMH1NestedStackResourceEC8FDDF4OutputsSWIFTMaineuwest1AMH13274066FRef"
                      }
                    ]
                  ]
                },
                {
                  "Fn::Join": [
                    "",
                    [
                      "arn:aws:ec2:eu-west-1:290945594156:instance/",
                      {
                        "Ref": "referencetoSWIFTMaineuwest1AMH2NestedStackAMH2NestedStackResource00C6A7E1OutputsSWIFTMaineuwest1AMH2D482D49DRef"
                      }
                    ]
                  ]
                }
              ]
            },
            {
              "Action": [
                "ssm:DescribeSessions",
                "ssm:GetConnectionStatus",
                "ssm:DescribeInstanceInformation",
                "ssm:DescribeInstanceProperties",
                "ec2:DescribeInstances"
              ],
              "Effect": "Allow",
              "Resource": "*"
            },
            {
              "Action": "ssm:TerminateSession",
              "Effect": "Allow",
              "Resource": "arn:aws:ssm:*:*:session/${aws:username}-*"
            }
          ],
          "Version": "2012-10-17"
        },
        "PolicyName": "SSMInstanceAccessPolicy",
        "Roles": [
          {
            "Ref": "SWIFTInstanceOperatorRoleEDD819B7"
          }
        ]
      },
      "Metadata": {
        "aws:cdk:path": "SWIFTMain-eu-west-1/IAMRole/SSMInstanceAccessPolicy/Resource"
      }
    },
*/
// SWIFT infrastructure role
/*

    "SWIFTInfrastructureRole829D3EE2": {
      "Type": "AWS::IAM::Role",
      "Properties": {
        "AssumeRolePolicyDocument": {
          "Statement": [
            {
              "Action": "sts:AssumeRole",
              "Condition": {
                "Bool": {
                  "aws:MultiFactorAuthPresent": "true"
                }
              },
              "Effect": "Allow",
              "Principal": {
                "AWS": {
                  "Fn::Join": [
                    "",
                    [
                      "arn:",
                      {
                        "Ref": "AWS::Partition"
                      },
                      ":iam::290945594156:root"
                    ]
                  ]
                }
              }
            }
          ],
          "Version": "2012-10-17"
        },
        "RoleName": "SWIFTInfrastructureRole"
      },
      "Metadata": {
        "aws:cdk:path": "SWIFTMain-eu-west-1/IAMRole/SWIFTInfrastructureRole/Resource"
      }
    },
    "SwiftInfrastructurePolicy6FCA4C4A": {
      "Type": "AWS::IAM::Policy",
      "Properties": {
        "PolicyDocument": {
          "Statement": [
            {
              "Action": "rds:Describe*",
              "Effect": "Allow",
              "Resource": "*"
            },
            {
              "Action": "ec2:Describe*",
              "Effect": "Allow",
              "Resource": "*"
            },
            {
              "Action": [
                "logs:List*",
                "logs:Describe*",
                "logs:Get*"
              ],
              "Effect": "Allow",
              "Resource": "*"
            },
            {
              "Action": [
                "ec2:Start*",
                "ec2:Stop*"
              ],
              "Effect": "Allow",
              "Resource": [
                {
                  "Fn::Join": [
                    "",
                    [
                      "arn:aws:ec2:eu-west-1:290945594156:instance/",
                      {
                        "Ref": "referencetoSWIFTMaineuwest1AMH1NestedStackAMH1NestedStackResourceEC8FDDF4OutputsSWIFTMaineuwest1AMH13274066FRef"
                      }
                    ]
                  ]
                },
                {
                  "Fn::Join": [
                    "",
                    [
                      "arn:aws:ec2:eu-west-1:290945594156:instance/",
                      {
                        "Ref": "referencetoSWIFTMaineuwest1AMH2NestedStackAMH2NestedStackResource00C6A7E1OutputsSWIFTMaineuwest1AMH2D482D49DRef"
                      }
                    ]
                  ]
                }
              ]
            }
          ],
          "Version": "2012-10-17"
        },
        "PolicyName": "SwiftInfrastructurePolicy",
        "Roles": [
          {
            "Ref": "SWIFTInfrastructureRole829D3EE2"
          }
        ]
      },

    }
  },
  */
