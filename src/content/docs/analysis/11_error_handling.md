---
title: Lambda using SQS Trigger Error Handling Strategy
description: Principles to follow to handle errors in lambdas which use SQS trigger
---

## Context

This strategy applies specifically to AWS Lambda functions that process messages from SQS, where these messages contain our application events.

## Final Strategy

The core of our error handling strategy revolves around the reliability and behavior of SNS (Simple Notification Service) and DLQ (Dead Letter Queue), which uses SQS (Simple Queue Service) to store failed messages. The strategy prioritizes eventual consistency and resilience over immediate success, based on the following principles:

### 1. Recoverable Errors

- If publishing to SNS fails, it is often due to transient issues like a temporary SNS outage.
- In such cases, we throw an error and let AWS reinsert the event for reprocessing.
- Although this may lead to event duplication, it is mitigated by downstream idempotent consumers.
- The trade-off here is minimal confusion in the audit logs in exchange for guaranteed event delivery.

### 2. Non-Recoverable Errors

- If the failure is deemed non-recoverable (e.g., due to invalid event data), we send the event to the DLQ.
- The DLQ, utilizing SQS, ensures these events are captured for later inspection and manual intervention.
- This approach helps isolate persistent issues from transient failures.

### 3. DLQ Failure

- If sending to the DLQ also fails, we treat it as a critical infrastructure issue. Note that here we are talking about sending to DLQ from lambda code.
- In this scenario, we throw an error and let AWS reprocess the entire event.
- This decision is based on the premise that simultaneous SNS and SQS failures indicate broader connectivity problems best handled by retrying later.

## Rationale for This Strategy

- **SNS as the Primary Event Channel:** SNS is the primary entry point for events. Its failure signals potential upstream disruptions.
- **DLQ as a Safety Net:** DLQ uses SQS to capture events that cannot be processed, ensuring no data is lost.
- **Balancing Retry and Duplication:** By allowing retries on recoverable failures, we maximize event delivery success, even at the cost of some duplication.

This strategy ensures robust event processing, leveraging AWS's retry mechanisms to handle transient failures while safely capturing persistent issues for manual resolution.
