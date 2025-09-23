---
title: Backup & Restore
description: Comprehensive backup & restore strategy for app data
---

## Overview

The only information that requires backup in our infrastructure is certain DynamoDB tables. We utilise out-of-the-box AWS solutions that offer a comprehensive plan, allowing us to establish policies for determining when backups are deleted and when they are moved to cold storage.

## Data Requiring Backup

### Tables with Automatic Backup

- **Users**: Critical table containing user information and configurations
- **AuditTrail**: Audit table for compliance and traceability

### Tables without Backup

- **RefreshTokens**: Temporary data with 7-day TTL
- **BusinessAlerts**: Data that expires in 24 hours
- **LambdaIdempotency**: Temporary data for deduplication

## AWS Solutions Utilised

### Point-in-Time Recovery (PITR)

- **What it is**: Automatic DynamoDB recovery up to 35 days back
- **Granularity**: Per second
- **Activation**: Automatic when `backup_config` is present in Terraform
- **Cost**: Included, no significant additional cost

### AWS Backup Plans

We implement a 2-tier strategy:

#### Tier 1: Weekly Backups (Days 35-105)

- **Frequency**: Working days at 6 AM UTC (`cron(0 6 ? * MON-FRI)`)
- **Retention**: 105 days
- **Storage**: Warm storage only (AWS doesn't allow cold storage for weekly backups)

#### Tier 2: Monthly Backups (Days 105-180)

- **Frequency**: 1st day of each month at 6 AM UTC (`cron(0 6 1 * ? *)`)
- **Retention**: 180 days (6 months total)
- **Storage**: Cold storage after 14 days (cost optimisation)
- **Deletion**: Automatic at 180 days (GDPR compliance)

## Testing Strategy

**We do not perform exhaustive backup testing** for the following reasons:

1. **Data volume**: The data is minimal, the impact of loss is limited
2. **Out-of-the-box solutions**: AWS Backup and PITR are mature and proven services
3. **Redundancy**: Testing AWS would be redundant (they already do it extensively)
4. **Cost-benefit**: The testing effort doesn't justify the real risk

### Manual Testing (Occasional)

Manual verifications can be performed using CLI commands to validate that backups are being created correctly.

## Manual Commands

### List Backups

```bash
aws dynamodb list-backups --table-name your-table-name
```

### Manual Backup

```bash
aws dynamodb create-backup \
  --table-name your-table-name \
  --backup-name "test-backup-$(date +%Y%m%d-%H%M%S)"
```

### Restore from Backup

```bash
aws dynamodb restore-table-from-backup \
  --target-table-name "your-table-restored-test" \
  --backup-arn "arn:aws:dynamodb:region:account:table/your-table/backup/backup-id"
```

### Restore Point-in-Time (PITR)

```bash
# Example: restore to 1 hour ago
aws dynamodb restore-table-to-point-in-time \
  --source-table-name your-table-name \
  --target-table-name your-table-pitr-test \
  --restore-date-time $(date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%S)
```

## Restore Options

### AWS Console (Recommended)

- **Pros**: Visual interface, easier to use
- **Cons**: Requires AWS console access
- **Process**: DynamoDB → Tables → [Table] → Backups → Restore

### AWS CLI (Programmatic)

- **Pros**: Scriptable, reproducible
- **Cons**: Requires command knowledge
- **Usage**: Ideal for automation or bulk restore

## Security Considerations

### IAM Permissions

Backup roles have minimum necessary permissions:

- `AWSBackupServiceRolePolicyForBackup`
- `AWSBackupServiceRolePolicyForRestores`

### Encryption

- Backups encrypted with dedicated KMS keys per environment
- Keys automatically rotated by AWS

### Access

- Only users with DynamoDB permissions can restore
- Restore creates new table (doesn't overwrite existing)

## Costs

### PITR

- ~20% of base table cost
- Included in most use cases

### AWS Backup

- **Warm storage**: ~$0.05 per GB-month
- **Cold storage**: ~$0.01 per GB-month (after 14 days)
- **Restore**: Charges per GB restored

### Optimisations

- Cold storage for monthly backups
- Automatic deletion at 180 days
- Scheduling on working days (daily operations)

## Future Steps

### Monitoring

- **CloudWatch Metrics**: AWS Backup automatically publishes metrics for backup/restore job success/failure and storage utilisation
- **Alerts**: Configure alerts for backup job failures, PITR disabled unexpectedly, and storage cost anomalies
