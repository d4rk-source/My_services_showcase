# Showcase Evidence Index

This file maps service outputs to concrete code locations in the demo contracts.

## DeFi Evidence Map

Service documents:

- `dapps/defi/services/01-smart-contract-audit/report.md`
- `dapps/defi/services/01-smart-contract-audit/diary.md`
- `dapps/defi/services/02-audit-readiness-prep/report.md`
- `dapps/defi/services/02-audit-readiness-prep/diary.md`
- `dapps/defi/services/03-security-strategy-incident-response/report.md`
- `dapps/defi/services/03-security-strategy-incident-response/report-post-incident-response.md`
- `dapps/defi/services/03-security-strategy-incident-response/diary.md`

Finding-to-code mapping:

- Weak privileged auth (`tx.origin`):
  - `dapps/defi/contracts/MehStakingLending.sol#L119`
  - `dapps/defi/contracts/MehStakingLending.sol#L125`
- External interaction before state reset in reward claim:
  - `dapps/defi/contracts/MehStakingLending.sol#L67`
- Missing post-withdraw health factor check:
  - `dapps/defi/contracts/MehStakingLending.sol#L85`
- Borrow/repay economic model surface:
  - `dapps/defi/contracts/MehStakingLending.sol#L99`
  - `dapps/defi/contracts/MehStakingLending.sol#L109`
- Unrestricted mock mint:
  - `dapps/defi/contracts/MockUSDC.sol#L47`

## Gambling Evidence Map

Service documents:

- `dapps/gambling/services/01-smart-contract-audit/report.md`
- `dapps/gambling/services/01-smart-contract-audit/diary.md`
- `dapps/gambling/services/02-audit-readiness-prep/report.md`
- `dapps/gambling/services/02-audit-readiness-prep/diary.md`
- `dapps/gambling/services/03-security-strategy-incident-response/report.md`
- `dapps/gambling/services/03-security-strategy-incident-response/report-post-incident-response.md`
- `dapps/gambling/services/03-security-strategy-incident-response/diary.md`

Finding-to-code mapping:

- Predictable roulette entropy:
  - `dapps/gambling/contracts/MehCasinoAndPrediction.sol#L53`
- Centralized market resolution:
  - `dapps/gambling/contracts/MehCasinoAndPrediction.sol#L129`
- Claim transfer before state reset:
  - `dapps/gambling/contracts/MehCasinoAndPrediction.sol#L143`
- `tx.origin` in privileged paths:
  - `dapps/gambling/contracts/MehCasinoAndPrediction.sol#L167`
  - `dapps/gambling/contracts/MehCasinoAndPrediction.sol#L173`
