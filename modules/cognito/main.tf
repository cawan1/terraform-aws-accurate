resource "aws_cognito_user_pool" "this" {
  name = "${var.project}-user-pool-${var.environment}"

  username_attributes = ["email"]
  auto_verified_attributes = ["email"]

}

resource "aws_cognito_user_pool_client" "this" {
  name = "${var.project}-user-pool-client-${var.environment}"

  user_pool_id = aws_cognito_user_pool.this.id
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
  generate_secret     = false
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  identity_pool_name = join("", [var.project, "IdentityPool", var.environment])
  s3_arn_private =  join("", [var.bucket_uploads_arn, "/private/$", "{cognito-identity.amazonaws.com:sub}/*"])
  authenticated_policy = {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
                "mobileanalytics:PutEvents",
                "cognito-sync:*",
                "cognito-identity:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Action": [
                "execute-api:Invoke"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:execute-api:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*/*"
      },
      {
        "Action": [
                "s3:*"
        ],
        "Effect": "Allow",
        "Resource": local.s3_arn_private 
      }

    ]
  }

  authenticated_assume_policy = {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow"
        "Principal": {
          "Federated": "cognito-identity.amazonaws.com"
        }
        "Action": [
          "sts:AssumeRoleWithWebIdentity"
        ],
        "Condition": {
          "StringEquals": {
            "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.this.id}"
          },
          "ForAnyValue:StringLike": {
            "cognito-identity.amazonaws.com:amr": "authenticated"
          }
        }
      }
    ]
  }

}

resource "aws_cognito_identity_pool" "this" {
  identity_pool_name               = local.identity_pool_name
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.this.id
    provider_name           = aws_cognito_user_pool.this.endpoint
    server_side_token_check = false
  }
  supported_login_providers = {
    #https://docs.aws.amazon.com/cli/latest/reference/cognito-identity/create-identity-pool.html
    "graph.facebook.com"  = var.facebook_app_id,
    "accounts.google.com" = "781500125343-f614562moml01daaehh5urrntsnlig3t.apps.googleusercontent.com"
  }
  openid_connect_provider_arns = ["arn:aws:iam::790261131557:oidc-provider/git.acclabs.com.br/gitlab/"]
}




resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = aws_cognito_identity_pool.this.id

  roles = {
    "authenticated" = "${aws_iam_role.authenticated.arn}"
  }
}



resource "aws_iam_role" "authenticated" {
  name = "${var.project}_cognito_authenticated_${var.environment}"
  assume_role_policy = jsonencode(local.authenticated_assume_policy)
}

#data "aws_region" "current" {}

resource "aws_iam_role_policy" "authenticated" {
  name = "${var.project}CognitoAuthorizedPolicy${var.environment}"
  role = aws_iam_role.authenticated.id
  policy = jsonencode(local.authenticated_policy)
}
