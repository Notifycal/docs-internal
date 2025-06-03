---
title: Stripe Payments Integration PRD [v1]
description: Product Requirements Document v1 (PRD)
---

## 🎯 Objective

Implement seamless Stripe-based payment infrastructure to support:

- Monthly subscriptions (Good/Better/Best tiers)
- One-time top-up credits
- Automatic billing with VAT compliance in Spain
- Transparent credit-to-SMS logic for users
- Internal observability and error alerting

---

## 🧭 Scope

### ✅ In Scope

| Feature                | Description                                               |
| ---------------------- | --------------------------------------------------------- |
| Subscriptions          | Good, Better, Best plans with included SMS credit         |
| Top-ups                | One-time purchase of additional credits                   |
| Stripe Checkout        | Hosted page with localized currency & branding            |
| Customer sync          | Create/update Stripe customer on login or payment         |
| Webhooks + EventBridge | Handle `checkout.session.completed`, `invoice.paid`, etc. |
| Invoicing              | Spanish invoices with 21% VAT auto-included               |
| Stripe Customer Portal | Card updates, plan changes, invoices                      |
| Credit System          | Internal balance logic in € mapped to SMS quantity        |
| Credit Estimation      | Display estimated SMS included per plan (price-dependent) |
| Observability          | Alerts on failed payments, webhook errors, cancellations  |

### ❌ Out of Scope (v1)

| Feature                    | Reason                                             |
| -------------------------- | -------------------------------------------------- |
| Multi-currency support     | Only EUR supported in v1 (Stripe auto-converts)    |
| Multi-account Stripe setup | Single Stripe account is sufficient                |
| Team billing               | One user = one customer = one invoice              |
| Discounts or coupons       | Manual beta-tester management only in v1           |
| Marketplace/Split payouts  | Notifycal is sole vendor — no need for Connect API |

---

## 💶 Pricing Tiers (Draft)

| Tier      | Price (IVA incl.) | Credit € | Est. SMS\* | Effective SMS Price | Comments     |
| --------- | ----------------- | -------- | ---------- | ------------------- | ------------ |
| 🟢 Good   | €10               | €3.41    | ~109       | €0.0917             | Entry tier   |
| 🟡 Better | €25               | €11.90   | ~382       | €0.0654             | Popular plan |
| 🔵 Best   | €60               | €26.06   | ~838       | €0.0581             | High-volume  |

> ⚠️ \*Estimated SMS assumes Spain rate of €0.03109/SMS. Actual may vary by destination.

---

## ✅ Functional Requirements

| ID   | Requirement                                      | Priority | Owner                 |
| ---- | ------------------------------------------------ | -------- | --------------------- |
| RF1  | Users must subscribe to a plan via UI            | High     | Frontend              |
| RF2  | Stripe Checkout must be used for payment         | High     | Backend               |
| RF3  | Credit must update on payment success            | High     | Backend               |
| RF4  | Users must be able to top up credits             | High     | Backend               |
| RF5  | User need to be alerted via email on low balance | Medium   | Backend               |
| RF6  | Auto-generate invoice with Spanish VAT           | High     | Stripe + Backend      |
| RF7  | Users manage subs via Stripe portal              | Medium   | Stripe config         |
| RF8  | UI shows credit left + estimated SMS             | High     | Frontend              |
| RF9  | Backend handles Stripe events                    | High     | Backend + EventBridge |
| RF10 | Alerting on failed/cancelled payments            | Medium   | Observability         |
| RF11 | Payment via cards + wallets (Apple/Google Pay)   | High     | Stripe config         |

---

## ❎ Non-Functional Requirements

| ID   | Requirement            | Description                                   | Priority |
| ---- | ---------------------- | --------------------------------------------- | -------- |
| RNF1 | Security               | No card data stored — Stripe handles payments | Critical |
| RNF2 | Uptime                 | Webhook/processing must be resilient          | High     |
| RNF3 | Compliance             | Invoices must meet Spanish tax law            | Critical |
| RNF4 | Scale                  | Infrastructure supports 1000+ payments/month  | Medium   |
| RNF5 | Operational Simplicity | Delegate invoicing + credits to Stripe        | High     |
| RNF6 | Branding               | Checkout + emails must match Notifycal theme  | Medium   |
| RNF7 | Observability          | Logs and metrics for every transaction        | High     |

---

## 📌 Notes

- Internally we use €-based credits, but show users estimated SMS.
- Future-ready to support price-per-country logic.
- First iteration skips coupons, promos, or complex billing logic.
- Beta testers are handled manually or via 100% discounts.

---

Let me know if you'd like to break this EPIC down into GitHub issues or add user stories in Gherkin syntax.
