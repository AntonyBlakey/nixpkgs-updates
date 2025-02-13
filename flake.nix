# flake.nix
{
  description = "Custom package collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        racket-minimal =
          (import nixpkgs {
            inherit system;
            overlays = [ (import ./overlays) ];
          }).racket-minimal;
        default = self.packages.${system}.racket-minimal;
      };

      # For devenv access
      racket-minimal =
        (import nixpkgs {
          inherit system;
          overlays = [ (import ./overlays) ];
        }).racket-minimal;
    });
}
