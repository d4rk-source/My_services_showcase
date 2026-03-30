# Service 03 — Protocol Security Strategy & Incident Response (DeFi)

## Security Strategy

### Phase 1: Immediate Hardening

- Remove `tx.origin` and enforce role-based privileges
- Apply checks-effects-interactions in all transfer paths
- Add emergency pause to borrowing and collateral withdrawals
- Add collateral health-factor checks

### Phase 2: Economic Safety

- Add debt interest accrual and reserve tracking
- Design liquidation path and penalties
- Add insolvency monitoring thresholds

### Phase 3: Operational Controls

- Move owner actions to multisig
- Add runbooks for parameter changes and emergency pauses
- Add on-chain and off-chain alerting for abnormal debt/liquidity movement

## Incident Response Plan

1. Detect and classify incident severity
2. Contain affected functions (pause/limit)
3. Preserve evidence (tx traces, events, timelines)
4. Patch and validate on testnet/fork
5. Publish concise post-incident report with fixes and prevention steps

## Deliverables

- 30/60/90 day protocol security roadmap
- Incident severity matrix
- Response communications template
