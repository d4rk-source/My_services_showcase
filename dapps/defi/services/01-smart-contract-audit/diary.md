# Audit Diary - DeFi

## How I Approached It

I started with an initial walkthrough of the full user journey: mint mock tokens, stake, earn rewards, deposit collateral, borrow, and repay. That gave me the architecture and business logic context before I spent time on individual weaknesses.

After that I focused on the control points that automated tooling would usually flag but not fully explain: privileged setters, payout ordering, and collateral transitions. I then mentally tested the simplest abuse paths in those flows to see whether the issues were real or just cosmetic.

## What I Focused On

- Whether users could move through the full protocol flow without friction
- Whether the protocol had obvious authority mistakes
- Whether the collateral model could be broken by a simple withdrawal path
- Whether the implementation felt realistic enough to be audited without being overengineered

## Methodology Notes

- I kept the review close to the actual architecture instead of chasing style issues.
- I prioritized manual reasoning over surface-level scanning because the target here is a service showcase, not a machine-only report.
- I organized the findings so they can be turned into follow-up fixes and verification work.

## Why These Findings Matter

The point was not to make the protocol impossible to use. The point was to leave it usable while preserving the kind of issues a client would actually hire someone to catch before launch.
