---
title: Create state bucket for TF/OpenTofu
description: Comparison between Parameter Store and Secrets Manager
sidebar:
  badge:
    text: deprecated?
    variant: note
---

:::note
It's still not clear whether we want to use `terragrunt` for this project. If we don't, this would still be useful. If we do, `terragrunt` is able to handle the state bucket creation exactly as we want (encryption, versioning, access_logs...).
:::

### Define variables

```bash
# Define variables
$ RANDOM_SUFFIX="6rvuikl3"
$ STATE_BUCKET_NAME="tofu-state-notifycal-${RANDOM_SUFFIX}"
$ DYNAMO_TABLE_NAME="tofu-lock-notifycal-${RANDOM_SUFFIX}"
$ STATE_BUCKET_REGION="eu-west-1"
```

### Create the bucket

```bash
$ aws s3api create-bucket \
  --bucket "${STATE_BUCKET_NAME}" \
  --region "${STATE_BUCKET_REGION}" \
  --create-bucket-configuration=LocationConstraint="${STATE_BUCKET_REGION}"
```

### Enable encryption

```bash
$ aws s3api put-bucket-encryption \
  --bucket "${STATE_BUCKET_NAME}" \
  --server-side-encryption-configuration "{\"Rules\": [{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\": \"AES256\"}}]}"
```

### Enable versioning

```bash
$ aws s3api put-bucket-versioning \
  --bucket "${STATE_BUCKET_NAME}" \
  --versioning-configuration Status=Enabled
```

### Create dynamo table for lock

```bash
$ aws dynamodb create-table \
    --table-name "${DYNAMO_TABLE_NAME}" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```
