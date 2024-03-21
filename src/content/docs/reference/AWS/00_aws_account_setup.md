---
title: AWS Account setup
description: Steps taken to setup and secure the AWS account
---

## AWS Account creation

1. Create an AWS account, following their wizard.
1. Enable MFA for the root user.
1. Enable IAM user and role access to Billing information. Go to "Account" then scroll down.
   ![enable_iam_billing_access](./images/iam_user_role_billing_access.png)
1. Setup an account alias if not done earlier. Go to `IAM > Dashboard` and click on `Create` below `Account Alias`.
   ![account_alias](./images/aws_account_alias.png).
1. Save the Sign-in URL as it will be the entrypoint to the AWS Console (UI).

## Budgeting and cost notifications

Using the Root Account, you just need to:

1. Go to `Billing and Cost Management > Billing Preferences` and enable the following:
   a. `PDF invoices delivery by email`
   b. `Receive AWS Free Tier alerts`
   c. `Receive Cloudwatch billing alerts`
   ![enable_billing_alerts](./images/billing_alerts_setup.png)
1. Create a cost budget.
   ![budget_creation](./images/budget_creation.png)  
   ![budget_created](./images/budget_created.png)

## Create `iamadmin` Administrator user

1. Create a `iamadmin` IAM User
   a. Enable Console (UI) access.
   b. Give it the IAM Role `AdministratorAccess`.
1. Log in with it.
1. Enable MFA.

### Enable programmatic access for `iamadmin`

1. Go to IAM > My Security credentials
1. Create Access key. Select CLI and check the box.
1. Click on `Create access key`.
1. Finally download the .csv file and save it somewhere safe.

## AWS CLI setup

Check how to [setup the AWS CLI](01_awscli.md) and verify it works correctly before moving into the next step.

## Enforce MFA everywhere

Right now MFA is enforced when logging into the AWS Console (UI) through the browser, but we also want to enforce it when using the CLI. In order to do that we need to create an IAM Policy.

### Create IAM Policy

The policy contents are in [aws/utils/enforce-mfa-policy.json](./utils/enforce-mfa-policy.json). Run the following command:

```bash
$ aws iam create-policy \
    --policy-name EnforceMFA \
    --policy-document file://$(pwd)/utils/enforce-mfa-policy.json \
    --description "This policy enforces MFA"

{
    "Policy": {
        "PolicyName": "EnforceMFA",
        "PolicyId": "ANPAVRUVTMT6C3Q7G5TZD",
        "Arn": "arn:aws:iam::<redacted>:policy/EnforceMFA",
        "Path": "/",
        "DefaultVersionId": "v1",
        "AttachmentCount": 0,
        "PermissionsBoundaryUsageCount": 0,
        "IsAttachable": true,
        "CreateDate": "2024-03-16T00:23:42Z",
        "UpdateDate": "2024-03-16T00:23:42Z"
    }
}
```

### Create IAM Group

Now we need to create an IAM Group:

```bash
$ aws iam create-group \
    --group-name EnforceMFA
{
    "Group": {
        "Path": "/",
        "GroupName": "EnforceMFA",
        "GroupId": "AGPAVRUVTMT6FOETRJYX6",
        "Arn": "arn:aws:iam::<redacted>:group/EnforceMFA",
        "CreateDate": "2024-03-16T00:26:59Z"
    }
}
```

After the Group has been created, we can now associate it with the IAM Policy created earlier. For that we need the Policy ARN (AWS returned it when we created the Policy earlier).

```bash
$ aws iam attach-group-policy \
    --policy-arn "arn:aws:iam::381492094204:policy/EnforceMFA" \
    --group-name EnforceMFA
```

All human users created moving forward should be added to this group, so MFA is enforced for them.

Move onto the next section: [MFA with AWS CLI](./02_mfa_with_awscli.md).
