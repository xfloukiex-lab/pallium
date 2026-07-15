# Contributing to Pallium

Pallium is early and building in the open. Until v1, the codebase moves fast and the
module contracts (option names, layer boundaries) may still change.

## Ground rules

- **License:** all contributions are accepted under Apache-2.0 (see `LICENSE`).
- **Local-first is non-negotiable.** No feature may add a cloud dependency, telemetry,
  or a non-loopback default bind. PRs that phone home are declined.
- **Security defaults stay safe.** deny-all egress, approval-gated dangerous calls,
  loopback-only services. Convenience never overrides a safe default.
- **Reproducibility.** Everything deploys through the Nix flake; no imperative install steps.

## Structure

- `flake.nix` — entry point; exposes `nixosModules.default`.
- `modules/` — one file per stack layer (see `ARCHITECTURE.md` for the 7 layers).
- `docs/` — the project website (GitHub Pages).

## Milestones

Work is organized by the roadmap in `ROADMAP.md` (M1–M6). Issues are tagged by milestone.
If you want to help, open an issue first so we don't duplicate in-flight work.
