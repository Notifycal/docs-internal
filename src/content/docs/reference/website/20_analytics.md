---
title: Analytics Setup
description: Google Tag Manager, Google Analytics, and Microsoft Clarity integration setup
---

## Overview

Our analytics implementation uses three main tools:

- **Google Tag Manager (GTM)**: Centralized script management platform
- **Google Analytics (GA4)**: Web analytics and user behavior tracking
- **Microsoft Clarity**: User session recordings and heatmaps

Google Tag Manager serves as our central hub for injecting analytics scripts, allowing us to add new tools without code deployments.

## Why Google Tag Manager?

Instead of installing individual tracking scripts for each analytics tool, GTM provides:

- **Centralized Management**: Add/remove analytics tools through GTM interface
- **No Code Deployments**: New analytics tools don't require application updates
- **Script Organization**: All third-party scripts managed in one place
- **Environment Control**: Different configurations for different environments

## Why We Removed PartyTown

We initially used [Astro PartyTown](https://docs.astro.build/en/guides/integrations-guide/partytown/) to delegate analytics scripts to a web worker, keeping them off the main thread for better performance.

However, PartyTown was causing errors and compatibility issues. See [PR #444](https://github.com/Notifycal/static-landing/pull/444) for detailed information about the specific issues encountered.

We decided to remove PartyTown and run analytics scripts directly on the main thread, prioritizing reliability over the potential performance benefits. Nonetheless, Google Chrome Lighthouse report did not seem to be affected by the service worker removal.

## Google Tag Manager Setup

For comprehensive setup instructions, refer to the official Google Tag Manager documentation:

- [Get started with Google Tag Manager](https://support.google.com/tagmanager/answer/14842164?hl=en)

### Core Concepts

**Account**: Top-level container for your organization

- One account per organization/company
- Contains multiple containers

**Container**: Holds tags, triggers, and variables for a specific website/app

- We use separate containers for different environments
- Each container has a unique Container ID (format: `GTM-XXXXXXX`)

### Environment Separation

We maintain separate GTM containers for different environments. **Dev Container** is used for for local development (`npm run dev`) too.

This separation ensures:

- Development analytics don't pollute production metrics
- Different configurations can be tested safely
- Clear separation of concerns between environments

## Google Analytics Integration

Google Analytics follows the same environment separation model as GTM since both are Google products.

### Setup Steps

For detailed configuration instructions, refer to the official Google documentation:

- [Set up Google Analytics with Tag Manager](https://support.google.com/tagmanager/answer/9442095?hl=en)

Basic setup overview:

1. **Create GA4 Properties**:
   - Development property for dev metrics
   - Production property for production metrics

2. **GTM Configuration**:
   - Add Google Analytics tags in respective GTM containers
   - Configure measurement IDs for each environment
   - Set up appropriate triggers (typically "All Pages")

3. **Event Tracking**:
   - Custom events can be configured through GTM
   - No code changes required for basic page tracking

### Key Concepts

**Property**: Contains analytics data for a website/app
**Measurement ID**: Unique identifier for GA4 property (format: `G-XXXXXXXXXX`)
**Stream**: Data collection stream within a property

## Microsoft Clarity Integration

For detailed integration instructions, refer to the official Microsoft documentation:

- [Microsoft Clarity GTM Integration](https://learn.microsoft.com/en-us/clarity/third-party-integrations/google-tag-manager#option-1-install-clarity-on-gtm-recommended-method)

Microsoft Clarity integrates seamlessly with Google Tag Manager through multiple methods.

### Recommended Setup (Option 1)

1. Go to Clarity Settings → Setup → Google Tag Manager
2. Sign in with your Google Account
3. Choose the appropriate GTM account and container
4. Select "Create and publish"

This method automatically:

- Creates the necessary GTM tag
- Links your Clarity project to GTM
- Publishes the configuration

### Environment Considerations

For Clarity, you can either:

- Use separate Clarity projects for dev/prod (recommended)
- Use the same project but filter by environment in Clarity dashboard

## Implementation Notes

- Each GTM container should have its corresponding analytics properties/projects
- Development container ID is shared between local development and dev deployments
- Only one Clarity tag can be linked to a specific Clarity project
- Project IDs can be found in respective platform URLs

## Resources

- [Google Tag Manager Help](https://support.google.com/tagmanager/)
- [Google Analytics Setup Guide](https://support.google.com/analytics/)
- [Microsoft Clarity GTM Integration](https://learn.microsoft.com/en-us/clarity/third-party-integrations/google-tag-manager)
