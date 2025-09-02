---
title: Overview
description: Multi AWS account access via single account
---

:::note[TL;DR]

Use **one hardened Management account** as the control plane (identity, CI trust, optional remote state) and **assume roles into target accounts** for all actions. You get **clean separation of concerns**, **strong governance**, **better security posture**, and **simpler day-to-day operations** without adding unnecessary complexity or cost.
:::

:::caution
Some of the "benefits" outlined in this document (ie: centralized billing, SCP...) relate to the use of **AWS Organizations**. We're not quite there yet, but we'll be.
:::

This setup centralizes human and CI access in one management (aka tooling) account, and uses STS `AssumeRole` to operate workloads in multiple target accounts (e.g., `prod`, `nonprod`). It cleanly separates governance & credentials from runtime resources, while keeping costs low and operations simple.

# Core idea

- **Login once** to Management (human via IAM Identity Center/SSO; CI via OIDC).
- **Operate everywhere** by assuming tightly-scoped roles in target accounts.
- [Optional] **Centralize Terraform/OpenTofu remote state** (S3 + DynamoDB + KMS) in the Management account.
- **Govern all accounts** under AWS Organizations with OUs and SCPs (to be done).

# High-level flow

## 1. Authenticate to the Management account

- **Humans**: SSO session (short-lived).
- **CI**: OIDC-backed role in Management (no long-lived secrets).

## 2. Terraform/OpenTofu bootstrap

- **Backend**: reads/writes remote state in Management (S3 + DynamoDB + KMS).
- **Providers**: for each target account, the AWS provider assumes a target role (e.g., TerraformRole) to create/update resources.

## 3. Execution in targets

- Actions happen in prod/nonprod using least-privilege roles, not root/users.
- SCPs and tagging policies enforce guardrails org-wide.

# Why we use it

## Security & governance

- **Blast radius reduction**: workloads live in separate accounts; mistakes in nonprod can’t directly impact prod.
- **Central trust anchor**: only the Management account issues credentials; all other access is via AssumeRole.
- **Organization-wide controls**: SCPs enforce region restrictions, mandatory tags, or service allow/deny lists across OUs.
- **Auditability**: central CloudTrail, consistent access patterns, fewer principals to monitor.
- **No long-lived secrets**: SSO for humans, OIDC for CI; roles are short-lived.

## Operations & developer experience

- **Single entry point**: developers and pipelines use one profile/role and switch to targets programmatically.
- **Consistent IaC**: one backend for state (optional), reusable modules, predictable provider aliases.
- **Clear ownership boundaries**: per-account budgets, tags, alarms, and quotas are easier to reason about.
- **Fewer surprises**: separating backend credentials (state) from provider credentials (resources) avoids common Terraform pitfalls.

## Cost & finance

- **Consolidated billing**: clean visibility by account/OU/tags; easier chargeback/showback.
- **Fine-grained budgets/alerts**: independent budget controls per account.

# Typical building blocks

- **AWS Organizations**: Management account, OUs for production and nonproduction.
- **SCPs**: region pinning (e.g., eu-west-1), tag enforcement, deny risky services globally.
- **Management account services**:
  - SSO/Identity Center + permission sets.
  - OIDC provider for CI (e.g., GitHub Actions).
  - Remote state: S3 (versioned) + DynamoDB locks + KMS CMK.
- **Target accounts**: minimal TerraformRole (assumable from Management) with least-privilege policies.

# Request/role model

```
Human/CI → (SSO/OIDC) → Management account
           ↳ (STS AssumeRole) → Target account: nonprod
           ↳ (STS AssumeRole) → Target account: prod
```

# Best practices

- **Harden Management**: MFA, minimal access, explicit SCP allowing only tooling services (S3, DynamoDB, KMS, STS, SSO, Organizations, IAM for OIDC).
- **Principle of least privilege**: keep policies tight.
- **Tag everything**: `project`, `env`, `owner`, `cost-center`; enforce via SCP or tag policies.
- **Rotate short-lived creds only**: never store long-lived access keys in CI.
- **Separate states if needed**: for stricter isolation, keep `prod` and `nonprod` in distinct state files (or even distinct buckets), while still centralizing in Management.

# When not to centralize state

- Extremely regulated environments may prefer **state per account** to maximize isolation. The access pattern still goes through Management; only the **backend location** changes.
