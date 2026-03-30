# Service 01 — Smart Contract Auditing (DeFi)

## Scope

- `contracts/MockUSDC.sol`
- `contracts/MehStakingLending.sol`

## Assessment Summary

The protocol supports expected user flows (stake, claim, collateralize, borrow, repay), but security assumptions are weak and not production-ready.

## Findings

### High

1. `tx.origin` used for privileged actions
   - Affected: `setRewardPerSecond`, `setCollateralFactorBps`
   - Risk: owner can be tricked through a malicious intermediary contract.
   - Recommendation: replace with explicit role checks on `msg.sender`.

2. Reward claim transfers before state update
   - Affected: `claimRewards`
   - Risk: fragile payout flow; unsafe interaction ordering.
   - Recommendation: apply checks-effects-interactions and non-reentrant guard.

### Medium

3. Collateral withdrawal lacks a health-factor check
   - Affected: `withdrawCollateral`
   - Risk: accounts may become undercollateralized after withdrawal.
   - Recommendation: enforce post-withdraw borrow safety validation.

4. No debt interest accrual
   - Affected: lending model
   - Risk: long-term insolvency pressure and weak economic controls.
   - Recommendation: add borrow interest + reserve model.

### Low

5. Mock token mint is unrestricted
   - Affected: `MockUSDC.mint`
   - Risk: unrealistic test economics.
   - Recommendation: admin-gated mint in realistic testing environments.

## Result

Current state is suitable as an educational prototype and a practical audit demo target; not suitable for real-value deployment.
