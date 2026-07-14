<!-- Pallium — self-hostable private AI stack. A VektorGeist project. -->

# Pallium

**A private AI you host yourself.** Run your own AI — local models, agent memory, private
retrieval, a hardened tool-gateway, and a sandboxed agent — on hardware you own, not in
someone else's cloud.

> **Status: early / in active development.** This repository is the design + skeleton of the
> project. It is **not yet a download.** Follow along as the pieces land.

The name says the idea: *pallium* is both the brain's **cortex** and a protective **cloak** —
your thinking layer, shielded and yours.

**Website:** https://xfloukiex-lab.github.io/pallium/ · **By:** [VektorGeist](https://vektorgeist.com)

---

## Why

The fediverse gave people sovereign social media (Mastodon) and self-hosted storage (Nextcloud).
But the newest and most invasive layer of the modern internet — **AI** — still lives almost
entirely inside a handful of Big-Tech clouds. Every prompt, document, and memory you give an AI
assistant leaves your control.

Pallium is the missing **private-AI service** for the self-hosting world: an easy-to-deploy stack
that runs a complete AI on a machine you own, with **service portability** and **personal
freedom** at the core.

## The stack (7 composable layers)

1. **Deployment** — declarative NixOS modules; one command brings the stack up, portable between hosts.
2. **Model serving** — local, on-device LLM inference. Nothing leaves the box.
3. **Memory & knowledge** — an agent memory/knowledge store you own, with a portable export format.
4. **Private retrieval** — local search over your own files and notes; no cloud index.
5. **Secure tool-gateway** — every tool call is checked: anti tool-poisoning, injection scanning,
   secret redaction, allow/deny, human approvals.
6. **Sandbox & egress control** — the agent runs OS-sandboxed with a network kill-switch.
7. **Control plane** — a local console to configure, monitor, approve, and export your whole stack.

See [`ARCHITECTURE.md`](ARCHITECTURE.md) for the full design and [`ROADMAP.md`](ROADMAP.md) for milestones.

## What's genuinely new

- A **single declarative security policy** spanning the tool, OS, and network boundaries at once.
- **Reproducible packaging** of a full private-AI stack (models + memory + tools + security) as NixOS modules.
- A **portable AI-state format** — move your memory, knowledge, and config between hosts (anti-lock-in).
- **Safe-by-default** posture that lets a non-expert run a capable autonomous agent at home.

## Open source

Everything Pallium ships is under **Apache-2.0**, in its entirety. Security tools earn trust by
being auditable, so the core is free and open. See [`LICENSE`](LICENSE).

## Project layout

```
pallium/
├── docs/            # the project website (GitHub Pages)
├── modules/         # NixOS module skeleton (the deployment substrate)
├── flake.nix        # Nix flake entry point (skeleton)
├── ARCHITECTURE.md  # full architecture + threat model
└── ROADMAP.md       # milestones
```

---

*Pallium is a [VektorGeist](https://vektorgeist.com) project.*
