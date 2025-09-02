---
title: AWS Account setup (management only)
description: Extra steps only required for management accounts
---

:::caution
The following steps are only required for the management account, there's no need to do them in the "environment" accounts (ie: `prod` and `nonprod`) as they won't have any kind of user access/login.
:::

# Add personal accounts/IAM Users

Add IAM Users as per your needs and make sure they log in and enable MFA before continuing with this guide. Otherwise they might end up locked out.

# Enforce MFA everywhere

Right now MFA is enforced when logging into the AWS Console (UI) through the browser, but we also want to enforce it when using the CLI. In order to do that we need to create an IAM Policy.

## Create IAM Policy

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

## Create IAM Group

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

All human users created moving forward should be added to this group, so MFA is enforced for them. Also add the `iamadmin` user to the group.

Move onto the next section: [MFA with AWS CLI](./02_mfa_with_awscli.md).
