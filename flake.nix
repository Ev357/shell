{
  description = "Quickshell";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      perSystem =
        { pkgs, system, ... }:
        {
          devShells.default = pkgs.mkShell {
            buildInputs = [
              inputs.quickshell.packages.${system}.default
            ];
          };
        };

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
