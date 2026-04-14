# Audit Diary - Gambling

## How I Approached It

I looked at the protocol the way a player or attacker would: what can be guessed, what can be influenced, and where the house keeps too much trust in a single actor. I started with the game architecture, then moved straight into the manipulation surfaces.

## What I Did

- Traced the roulette flow first because randomness quality is usually the biggest issue in gambling dApps
- Reviewed the market settlement path for trust assumptions
- Checked payout order and admin controls for obvious mistakes
- Kept the design intentionally simple so the security story stays readable

## Methodology Notes

- The review started broad and then narrowed to the easiest exploitation paths.
- I let the protocol shape drive the findings instead of forcing generic issues onto it.
- The end result is meant to sound like an audit note, not marketing copy.

## Why These Findings Matter

The protocol still works, but the weaknesses are visible enough to turn implementation details into client-facing risk language.
