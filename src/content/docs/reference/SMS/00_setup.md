---
title: SMS integration - Vonage
description: Vendor choice, context and overview
---

## Overview

This document outlines our SMS provider setup using Vonage (formerly Nexmo), including the business context behind our vendor choice, key contacts, and references to technical configuration.

## Why Vonage?

Our journey to SMS integration began with a different objective. Initially, the project was designed around **RCS (Rich Communication Services)** integration, which was our primary goal until we reached a critical limitation that forced us to pivot.

### The Evolution: RCS � SMS

- **Original plan**: RCS integration for rich messaging capabilities
- **Challenge encountered**: Technical limitations that prevented RCS implementation
- **Solution**: Pivoted to SMS using the same Vonage API
- **Decision factors**:
  - Vonage's API supports both RCS and SMS seamlessly
  - Competitive per-message pricing structure
  - No need to change vendor or start integration from scratch
  - Proven API reliability and support

## Key Contacts

We maintain direct relationships with Vonage representatives for both business and technical matters:

### Account Management

- **Noelia** - Account Manager
- Handles business relationships, contracts, and commercial inquiries

### Technical Support

- **Cristobal** - Technical Contact
- Primary point of contact for integration questions and technical support
- Has assisted with implementation doubts and API-related queries

_Note: Contact emails are stored securely in our internal systems_

## Technical Implementation

For detailed technical configuration and setup procedures, refer to:

- [Manual Configuration Guide](./01_manual_configuration.md) - Step-by-step setup process

## Service Architecture

Our SMS integration is implemented through:

- **Provider**: Vonage (Nexmo dashboard interface)
- **API**: Vonage Messages API v1
- **Integration**: Webhook-based with JWT signing
- **Infrastructure**: Deployed via IaC
