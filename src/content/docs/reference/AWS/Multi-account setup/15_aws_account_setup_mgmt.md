---
title: AWS Account setup (management only)
description: Extra steps only required for management accounts
---

:::caution
The following steps are only required for the management account, there's no need to do them in the "environment" accounts (ie: `prod` and `nonprod`) as they won't have any kind of user access/login.
:::

# Add personal accounts/IAM Users

Add IAM Users as per your needs and make sure they log in and enable MFA before continuing with this guide. Otherwise they might end up locked out.

All human users created moving forward should be added to the MFA group created in the previous page, so MFA is enforced for them.

Move onto the next section: [MFA with AWS CLI](./02_mfa_with_awscli.md).
