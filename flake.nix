{
  # Pallium — self-hostable private AI stack.
  # SKELETON: this flake declares the intended shape of the project. The layer
  # implementations land across milestones M1–M6 (see ROADMAP.md). A VektorGeist project.
  description = "Pallium — a self-hostable private AI stack (models + memory + retrieval + secure gateway + sandboxed agent)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      # The composable NixOS module. A host imports this and sets `services.pallium.enable = true`.
      nixosModules.default = import ./modules;
      nixosModules.pallium = self.nixosModules.default;

      # TODO(M5): a reference host profile that brings the whole stack up on a small VPS.
      # nixosConfigurations.reference = ...

      # TODO(M2): packages.<system>.warden-core = ...  (the standalone secure tool-gateway)
      packages = forAll (system: { });

      # Dev shell for working on the modules.
      devShells = forAll (system:
        let pkgs = import nixpkgs { inherit system; };
        in { default = pkgs.mkShell { packages = [ pkgs.nixpkgs-fmt ]; }; });
    };
}
