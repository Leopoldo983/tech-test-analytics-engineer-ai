# Revenue policy — Finance

*Owner: Finance. This is the definition every revenue report at Twin Hearth is measured against.
If a report disagrees with this document, the report is wrong.*

## Fiscal calendar

The fiscal year starts on **1 October**. FY2026 runs 2025-10-01 → 2026-09-30.
Fiscal Q1 = Oct–Dec, Q2 = Jan–Mar, Q3 = Apr–Jun, Q4 = Jul–Sep.

## Net revenue

```
net revenue = (gross - refunds) net of the platform fee
```

* **Gross** is what the player paid, in the currency they paid in.
* **Platform fee** is the store's cut. Each store's cut is set by contract and **changes over
  time**; the rate in force **on the date of the order** is the one that applies. The current
  schedule is in `platform_fees`.
* **Refunds** reduce revenue and the platform refunds its fee along with them.

## Currency

Everything is reported in USD. Non-USD orders are converted using the **last published rate on or
before the order date**. Rates are published on business days only — there is no Saturday rate, and
an order placed on Saturday converts at Friday's rate.

## Refunds

The **refunds table is the system of record**. It contains full refunds and partial refunds
(goodwill credits, price adjustments); a partially refunded order is still a completed order.

Refunds are attributed **to the date of the original order** for revenue reporting, and to the date
of the refund itself for cash reporting. The two do not agree in any given month, and that is
expected.

## Scope

Reported revenue covers **completed orders from real players**.

* Orders that never completed are not revenue.
* **Internal, test and QA accounts are excluded from every reported metric.** Staff and QA buy
  through the live stores, so their activity is in the same tables as everybody else's.

## Settlement

Stores pay out on a delay that varies by store (30 to 60 days). Revenue is recognised on the order
date; cash arrives on the settlement date. Reports that mix the two are the single most common
source of "why doesn't this match the bank" escalations.
