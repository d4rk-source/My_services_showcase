# Web3 Security Demo Showcase

This repository demonstrates security services in action on two intentionally security-light demo dApps:

- DeFi (`dapps/defi`): staking + collateralized borrowing
- Gambling (`dapps/gambling`): roulette + prediction market

Both demos are designed to be functional while still containing common, non-exotic mistakes that are realistic in early-stage protocols.

## Service Showcase Coverage

Each dApp folder contains deliverables for the three core services listed on https://www.alexcipher.xyz/:

1. Smart Contract Auditing
2. Audit Readiness & Competition Prep
3. Protocol Security Strategy & Incident Response

See:

- `dapps/defi/services/`
- `dapps/gambling/services/`

## Existing Reference Projects

Imported reference projects are preserved and unchanged:

- `dapps/defi/contracts/Never-Poor-Again`
- `dapps/gambling/contracts/DiceFate`

The showcase contracts added at the top level of each `contracts/` folder are intentionally simpler to make service output easy to inspect.
