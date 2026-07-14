# Pallium — Roadmap

Pallium is in active development. The milestones below are ordered; each is independently useful
even if the whole is not adopted.

| Milestone | Focus | Deliverable (all open-source) |
|-----------|-------|-------------------------------|
| **M1** | Deployment framework | NixOS `flake.nix` + composable module skeleton; one-command bring-up on a reference VPS + home server; docs |
| **M2** | Secure tool-gateway | `warden-core` hardened: schema/description pinning, injection scanning, secret redaction, approvals — standalone open-source package with a test suite |
| **M3** | Model + memory + retrieval | Local model serving + agent memory + private retrieval integrated: a working, fully-local private chat/agent |
| **M4** | Sandbox + egress | OS-sandboxed agent + egress kill-switch + network policy; the unified policy (N1) spanning tool + OS + network |
| **M5** | Console + portability | Admin console + one-click installer + AI-state export/import (N3) with a round-trip demo |
| **M6** | v1 release | Docs, independent security review, packaging, tagged v1; a Fediversity/self-hosting NixOS module upstreamed |

**Independently useful pieces:** the secure gateway (M2), the portable AI-state format (M5), and
the self-hosting module (M6) each stand alone.

*Status is tracked in the repository. This roadmap describes intended scope, not commitments on dates.*
