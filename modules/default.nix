# Pallium — top-level NixOS module (SKELETON).
#
# Declares the option surface for the 7 layers. Implementations land across M1–M6
# (see ../ROADMAP.md). Enabling a host with `services.pallium.enable = true` and
# turning on the layers you want is the intended UX. A VektorGeist project.

{ config, lib, pkgs, ... }:

let
  cfg = config.services.pallium;
  inherit (lib) mkEnableOption mkOption types mkIf;
in
{
  imports = [ ./gateway.nix ./sandbox.nix ];

  options.services.pallium = {
    enable = mkEnableOption "the Pallium private AI stack";

    # Layer 2 — model serving
    modelServing = {
      enable = mkEnableOption "local model inference (localhost only)";
      # TODO(M3): backend (ollama | llama-cpp), model registry, GPU/CPU selection.
    };

    # Layer 3 — memory & knowledge
    memory = {
      enable = mkEnableOption "the agent memory / knowledge store";
      # TODO(M3): store path, portable export/import (N3).
    };

    # Layer 4 — private retrieval
    retrieval = {
      enable = mkEnableOption "local private retrieval over your own files";
      # TODO(M3): indexed sources (files/notes), all local.
    };

    # Layer 5 (gateway) and layer 6 (sandbox) live in ./gateway.nix and ./sandbox.nix.

    # Layer 7 — control plane
    console = {
      enable = mkEnableOption "the local admin console";
      # TODO(M5): bind address (localhost), export/import of the whole stack.
    };
  };

  config = mkIf cfg.enable {
    # TODO(M1): compose the enabled layers into services, users, and firewall rules.
    # Intentionally minimal in the skeleton so `enable = true` is a no-op until layers land.
    assertions = [{
      assertion = true;
      message = "Pallium is in development; layer implementations land across M1–M6.";
    }];
  };
}
