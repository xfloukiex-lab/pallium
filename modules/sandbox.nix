# Pallium layer 6 — agent sandbox + egress control.
# M4 milestone: namespaces/cgroups/seccomp profile + nftables egress rules land here.
{ config, lib, pkgs, ... }:

let
  cfg = config.services.pallium.sandbox;
  inherit (lib) mkEnableOption mkOption types mkIf;
in
{
  options.services.pallium.sandbox = {
    enable = mkEnableOption "OS-sandboxed agent execution";

    egress = mkOption {
      type = types.enum [ "deny-all" "allow-list" "open" ];
      default = "deny-all";
      description = "Network egress policy for the sandboxed agent. deny-all (kill-switch) is the default.";
    };

    allowedHosts = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Hosts the agent may reach when egress = allow-list.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [{
      assertion = cfg.egress != "allow-list" || cfg.allowedHosts != [ ];
      message = "pallium.sandbox: egress=allow-list requires at least one allowedHosts entry.";
    }];
  };
}
