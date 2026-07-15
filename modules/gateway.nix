# Pallium layer 5 — secure tool-gateway (warden-core).
# M2 milestone: the gateway implementation lands here. This module defines the
# option surface and service wiring contract ahead of the implementation.
{ config, lib, pkgs, ... }:

let
  cfg = config.services.pallium.gateway;
  inherit (lib) mkEnableOption mkOption types mkIf;
in
{
  options.services.pallium.gateway = {
    enable = mkEnableOption "the secure tool-gateway (schema pinning, injection scan, redaction, approvals)";

    policyFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Declarative gateway policy (allow/deny, pin store, approval mode). Null = safe defaults (deny-unknown, approve-on-first-use).";
    };

    approvalMode = mkOption {
      type = types.enum [ "cli" "console" "auto-first-use" ];
      default = "cli";
      description = "How dangerous tool calls are approved. Changed/quarantined tools always require human approval.";
    };

    listenAddress = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Bind address. Localhost only by default — the gateway is not an internet-facing service.";
    };
  };

  config = mkIf cfg.enable {
    # M2: systemd service + state dir + pin database land here.
    assertions = [{
      assertion = cfg.listenAddress == "127.0.0.1" || cfg.listenAddress == "::1";
      message = "pallium.gateway: refusing a non-loopback bind — the gateway is local-first by design.";
    }];
  };
}
