# Service 02 — Audit Readiness & Competition Prep (DeFi)

## Readiness Goal

Move the protocol from prototype-quality code to a state where external auditors and contest participants can evaluate it efficiently.

## Gaps Observed

- No explicit threat model or trust assumptions
- Missing documented list of privileged operations
- Missing invariants for collateral/debt safety
- No emergency response controls

## Prep Work Performed

1. Scope framing and trust-boundary mapping
2. Finding triage matrix (must-fix vs acceptable known-risk)
3. Invariant checklist draft for reviewers
4. Contest/audit package outline (scope, assumptions, known issues)

## Must-Fix Before External Review

- Remove `tx.origin` access checks
- Reorder external interactions and state updates in payout paths
- Add health checks for collateral withdrawals
- Add pausable controls and governance-safe admin boundaries

## Outcome

Readiness moved from low to moderate with clear, prioritized hardening tasks.
