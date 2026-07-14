# Pallium — Architecture

> Design document. Pallium is in active development; this describes the intended v1 design.
> Everything ships under an open-source license (Apache-2.0).

## Summary

Pallium is a self-hostable **private AI stack**: composable NixOS modules plus a local control
plane that let a person or small community run their own AI — local model inference, agent
memory/knowledge, private retrieval over their own data, a hardened tool-gateway, and an
OS-sandboxed agent with egress control — on hardware they own. It is the "private-AI service"
the self-hosting world is missing, built to the same values (declarative deployment, service
portability, personal freedom, no lock-in).

## The 7 layers (each a Nix module)

1. **Deployment substrate.** A `flake.nix` exposing a top-level `pallium` NixOS module that
   composes the layers via typed options. Goal: `nixos-rebuild switch` (or a bundled installer)
   brings the whole stack up reproducibly on a home server or a small VPS.
2. **Model serving.** Local, OpenAI-compatible inference (e.g. Ollama / llama.cpp) on localhost.
   Hardware-adaptive (CPU or GPU); a model registry in config; optional multi-machine pooling.
3. **Memory & knowledge.** A local structured fact/knowledge store + document store, with a
   documented, portable export/import format — your "AI state" is yours to move (see N3).
4. **Private retrieval.** Federated local retrieval over the user's own files/notes. No cloud, no
   third-party index.
5. **Secure tool-gateway (`warden-core`).** Every tool/MCP call the agent makes is mediated:
   schema/description **hash-pinning** (blocks rug-pulls / tool-poisoning), **prompt-injection
   scanning** on tool descriptions and results, **secret redaction**, allow/deny policy, and
   human-in-the-loop **approvals** for dangerous actions. This is the security spine, and it is
   independently useful to any self-hosted agent.
6. **Agent sandbox + egress control.** The agent runs inside an OS-enforced sandbox (Linux
   namespaces/cgroups/seccomp), with an **egress kill-switch** and per-destination network policy,
   so a compromised or misbehaving agent cannot exfiltrate data or phone home unless allowed.
7. **Control plane.** A local admin console to configure, monitor, approve tool actions, manage
   models/memory, and **export/import the whole stack** (service portability).

## What is genuinely new (the research)

- **N1 — Unified security policy across three boundaries.** The tool-boundary (gateway), the OS
  boundary (sandbox), and the network boundary (egress) are separate, hand-configured concerns
  today. Pallium researches a **single declarative policy** spanning all three, compiled down to
  gateway rules + sandbox profile + egress rules.
- **N2 — Reproducible declarative packaging of a full private-AI stack** (models + memory +
  retrieval + tool-security + sandbox) as one composable Nix module set that degrades gracefully
  on modest hardware.
- **N3 — Portable AI-state format.** A documented, implementation-independent export/import of
  agent memory + knowledge + configuration, so a person can move their AI between hosts.
- **N4 — Turnkey *safe* autonomous agent for non-experts** — the safe-by-default posture (gateway
  + sandbox + egress on by default) that makes it safe to run a capable agent at home.

## Threat model (scope of the security claims)

**Addressed:** tool-poisoning / description rug-pulls (pinning); prompt injection via tool
descriptions/results (scanner + approvals); secret exfiltration (redaction + egress control);
a compromised/misbehaving agent damaging the host (sandbox); untrusted tool supply chain
(allow/deny + approvals).

**Explicitly out of scope for v1:** nation-state host compromise, hardware side-channels, and
defending a user who disables the safe defaults. v1 protects a normal self-hoster from realistic
agent-era threats, not from a targeted APT.

## Fit with self-hosting / the open internet

The self-hosting world already has sovereign social (Mastodon/PixelFed/PeerTube), messaging
(Matrix), and storage (Nextcloud). Pallium adds the missing **private-AI service** on the same
declarative substrate, with the same values: portability, personal freedom, no lock-in.
