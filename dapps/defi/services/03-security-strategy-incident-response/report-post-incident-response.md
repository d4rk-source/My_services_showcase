# Post-Incident Response Strategy Report - DeFi

## Methodology Followed

1. Protocol deep dive: reviewed the same protocol through the lens of an incident or suspected compromise.
2. Risk assessment: identified the most likely emergency scenarios and recovery blockers.
3. Strategy development: planned the response flow, communication path, and recovery sequence.
4. Report delivery: documented what to do before, during, and after an incident.

## Response Strategy

### Incident Classes

- Fund risk: exploit or insolvency pressure affecting protocol balances
- Governance risk: privileged key misuse or parameter abuse
- Logic risk: faulty reward, collateral, or debt behavior discovered after deployment

### Response Flow

1. Detect and classify the issue quickly.
2. Pause or restrict affected protocol paths.
3. Preserve logs, traces, and timing data.
4. Apply a hotfix or mitigation on a fork/testnet first.
5. Communicate the issue and remediation status clearly.
6. Resume with post-incident controls in place.

## Deliverables

- Severity matrix for incident handling
- Communication template for stakeholders
- Recovery checklist for balances, governance, and user messaging

## Consultation Notes

This report sits alongside the security strategy report. The first report gives the roadmap; this one gives the recovery path if something goes wrong after the roadmap lands.
