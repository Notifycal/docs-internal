---
title: Installing pip packages on their own virtualenv
description: Installing pip packages on their own virtualenv.
---

This is using the AWS CLI as an example but should apply to any `pip` packages.

```bash
# Navigate to your home directory
$ cd ~

# Create a folder for Python virtualenvs
$ mkdir -p ~/pyvenvs

# Create a virtualenv
$ virtualenv ~/pyvenvs/aws
created virtual environment CPython3.12.1.final.0-64 in 346ms
  creator CPython3macOsBrew(dest=/Users/dan/pyvenvs/aws, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, via=copy, app_data_dir=/Users/dan/Library/Application Support/virtualenv)
    added seed packages: pip==23.3.1
  activators BashActivator,CShellActivator,FishActivator,NushellActivator,PowerShellActivator,PythonActivator

# install the AWS CLI into the virtualenv
$ ~/pyvenvs/aws/bin/pip install awscli

# Check it's setup correctly
$ ~/pyvenvs/aws/bin/aws --version
aws-cli/1.32.64 Python/3.12.1 Darwin/23.2.0 botocore/1.34.64

# Create symlink to directory in PATH to avoid activating the virtualenv
$ sudo ln -s ~/pyvenvs/aws/bin/aws /usr/local/bin/aws
$ sudo ln -s ~/pyvenvs/aws/bin/aws_completer /usr/local/bin/aws_completer

# Check it works without the full path
$ aws --version
aws-cli/1.32.64 Python/3.12.1 Darwin/23.2.0 botocore/1.34.64
```

Reference (kind of): https://github.com/aws/aws-cli#installation
