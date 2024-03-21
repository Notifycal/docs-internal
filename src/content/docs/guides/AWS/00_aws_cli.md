---
title: Setting up the AWS CLI
description: This guide details how to install and configure the AWS CLI
---

## Install

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

### Setup autocompletion

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux

## Configure

You should have a .csv file with an `Access key ID` and a `Secret access key`.

```bast
$ AWS_PROFILE=notifycal aws configure
AWS Access Key ID [None]: AXXXXXXXXXXXXXXXXXXX
AWS Secret Access Key [None]: <redacted>
Default region name [None]: eu-west-1
Default output format [None]: json
```

Check the files created in `~/.aws`, you should be familiar with their format for future steps. See how the value of `AWS_PROFILE` defines a block in both `credentials` and `config` files.

Now if you run a command against AWS, it will likely fail as you don't have a default profile, nor a `AWS_PROFILE` env var setup.

```bash
$ aws sts get-caller-identity
Unable to locate credentials. You can configure credentials by running "aws configure".

$ export AWS_PROFILE=notifycal
$ aws sts get-caller-identity
{
    "UserId": "<redacted>",
    "Account": "<redacted>",
    "Arn": "arn:aws:iam::<redacted>:user/<username>"
}
```

## Utilities

### AWS shell functions

Check Reference > AWS > Utils > aws_functions.zsh` in the sidebar for more detail.

Some interesting functions are:

- `awsprof` lets you switch between AWS profiles interactively by setting the AWS_PROFILE env var.
- `assume-role` allows you to impersonate a given IAM Role.
- `mfa` use TOTP codes for AWS CLI MFA (more detail in the next steps).

### [aws-mfa](https://github.com/broamski/aws-mfa)

Required for the `mfa` shell function above.
