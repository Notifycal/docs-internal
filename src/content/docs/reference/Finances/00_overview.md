---
title: Financial Model & Pricing
description: Documentation of the financial model, assumptions, and strategic rationale behind pricing.
---

## Summary

This page documents how Notifycal’s finances are currently modelled: the sheets we use, the assumptions applied, the rationale behind our pricing decisions, and the insights gained from the **Rendimiento** (1)) analysis.  
It also outlines the **strategic role of our tiers**, why some approximations are deliberate, and the **next steps** as we move from estimations towards actual financial operations.  
**Important:** the _credits_ layer is a **marketing abstraction** for simplifying cross-country SMS pricing. It is **not part of the financial model**. In finance we only work with **customers, tier pricing, messages sent, and associated costs**.

---

## 1) Sources and scope

- [**Finanzas**](https://docs.google.com/spreadsheets/d/1R6Ehcpe6OGoYOs_168yd0Lg7WXDaN1IJkqz3LbskWmE/edit?pli=1&gid=838370589#gid=838370589):
  - '**Rendimiento**' sheet: assumptions at the top (rows 1–13; row 14 unused), results and metrics below.
  - '**[Graficas] Rendimiento**' sheet: graphical representation of key metrics from _Performance_.
  - '**Costes_Variables**' and '**Costes_Fijos**' sheets: cost breakdowns, some still estimated.

- [**Espionage de competencia**](https://docs.google.com/spreadsheets/d/1FIdonjxXC4st2ZVtB3h4CaCADRgNEd8YFcZerPzwN-Q/edit?gid=0#gid=0):
  - Benchmarking competitors’ tiers, SMS pricing, and positioning helped us define our own **subscription pricing strategy**.

---

## 2) Pricing strategy and tier rationale

Our subscription tiers are not equally designed for profitability. Each has a specific strategic role:

- **Good Tier**
  - Intentionally less profitable.
  - Purpose: act as a **gateway for adoption**, since we have no free tier.
  - Strategy: keep price and allowance (messages included) low enough to reduce friction for trial.
  - Expectation: once customers test the service and see its value, they will either:
    - Purchase top-ups, or
    - Upgrade to the _Better_ tier.

- **Better Tier**
  - Our **strategic focus**.
  - As shown in performance charts, this tier is significantly more profitable.
  - Customers are likely to leave unused message capacity, which increases margins.

- **Best Tier**
  - Designed for **clinics and high-volume businesses**.
  - Based on market knowledge and conversations, these customers handle **40–60 appointments per day**, making them highly profitable for Notifycal.
  - Price was intentionally capped below the _three-digit threshold_ (€100), as we believe potential customers might hesitate to commit to higher monthly fees with a new provider.
  - At present, all tiers are functionally identical apart from the number of messages included.
  - In the future, we may enrich _Better_ and _Best_ tiers with exclusive features (e.g. advanced customisation, priority support) to reinforce the value proposition, but our current view is that most customers will choose tiers primarily based on **volume of reminders needed**.

This tier design reflects a balance: **ease of entry with Good**, **profitability through Better**, and **a strong option for high-volume clinics via Best**.

- **Future tiers (potential adjustments)**  
  We do not rule out introducing new tiers in either direction:
  - **Higher tier**: if clinics or other businesses require more than 1,200 messages per month (e.g. 1,500–1,800), or if international markets with higher SMS costs (e.g. France at 2.5× Spain) make consumption faster.
  - **Lower tier**: less likely, but theoretically possible if we expand to countries with very low SMS costs.

In practice, this means the tier system is flexible and may evolve depending on **customer volume, international pricing, and market demand**.

---

## 3) Assumptions (Performance sheet inputs)

- **Tier mix (customer distribution)**:
  - _Good_: **35%**
  - _Better_: **50%**
  - _Best_: **15%**
- **Average customer lifetime**: 12 months.
- **Churn rate**: 5%.
- **Subscription prices**: set by competitor benchmarking.
- **Messages per tier**: defined internally; used to compute message-dependent costs.

---

## 4) Variable costs

- **Revenue-dependent**
  - Stripe fee: 1.5% (applied on net instead of gross; accepted simplification).
  - Infrastructure: 10% of revenue (conservative placeholder).
  - Marketing: 5% reinvestment of revenue (though early stage may involve fixed injections).
  - Safety margin: 7% (buffer for unknowns).

- **Transaction-dependent**
  - Stripe fixed fee per transaction: €0.25 (also applied on net).

- **Message-dependent**
  - SMS cost baseline: Vonage Spanish rate.
  - International rates: handled by applying multipliers (e.g. France = 2.5×).
  - Subscription tier prices remain constant.

---

## 5) Fixed costs

- Two salaries at €1,500 each.
- Two self-employed (autónomo) contributions.
- IRPF: calculated jointly as a lump, approximate for now.

---

## 6) Insights from performance analysis

- **Volume is crucial**:
  - Margins expand significantly once fixed costs are absorbed.
- **Break-even thresholds**:
  - ~170 customers → covers one salary.
  - ~600 customers → business becomes sustainably profitable.
- **Margin ceiling**:
  - Margins plateau at ~40–45%.
  - Plateau occurs at ~1,200–1,300 customers.
  - Indicates long-term healthy scalability.

---

## 7) Purpose of this model

This version of the financial model was **never meant to be final**.  
Its purpose was to answer a few core questions:

- Is the business viable?
- What subscription prices make sense?
- Roughly, what scale is needed to reach profitability?

It is intentionally **simplified**:

- Stripe fees calculated on net, not gross.
- Infrastructure % placeholder.
- IRPF approximated.

These shortcuts are acceptable because the goal was **to validate viability and set pricing**, not to produce tax-ready accounts.

---

## 8) Next steps: towards professionalisation

This model will serve for the **first 2–3 months** hopefully until we realise we can make a living our of Notifycal, but future financial decision-making (e.g. loans, hiring, feature investments) requires more robustness. Even a Chief Financial Officer so one of us can stop pretending being one.

Next steps:

1. **Move beyond spreadsheets**: adopt dedicated financial software to save time and avoid errors.
2. **Integrate with accounting**:
   - Invoices already come to us.
   - We could categorise them internally and export structured data for the gestoría (accountant).
   - Alternatively, integrate directly with financial software.
3. **Replace estimates with actuals**:
   - Feed real costs and revenues into the model.
   - Continuously improve precision in churn, LTV, and customer mix.

The long-term vision is a **feedback loop** where actuals replace assumptions, ensuring our financial planning grows in professionalism as Notifycal scales.

---
