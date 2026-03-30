# Service 01 — Smart Contract Auditing (Gambling)

## Scope

- `contracts/MehCasinoAndPrediction.sol`

## Assessment Summary

Gameplay is functional, but fairness and payout protections are not strong enough for production use with real funds.

## Findings

### High

1. Predictable roulette entropy
   - Affected: `playRoulette`
   - Risk: outcomes may be influenced or predicted by advanced actors.
   - Recommendation: use verifiable randomness or robust commit-reveal flow.

2. `tx.origin` used for privileged actions
   - Affected: `setHouseEdgeBps`, `houseWithdraw`
   - Risk: privilege can be abused via malicious intermediary calls.
   - Recommendation: role checks on `msg.sender` with multisig admin.

### Medium

3. Claim flow sends ETH before resetting user state
   - Affected: `claim`
   - Risk: weak interaction ordering in payout path.
   - Recommendation: reset state before transfers and add reentrancy guard.

4. Market resolution is centrally trusted
   - Affected: `resolveMarket`
   - Risk: users depend fully on a single resolver for final outcomes.
   - Recommendation: add oracle/dispute process and governance constraints.

## Result

Current state is a valid demonstration target for audit services, but not safe for production-value wagering.
