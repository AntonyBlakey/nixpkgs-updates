# flake.nix
{
  description = "Custom package collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = import ./overlays;
    in
    {
      overlays.default = overlay;
    } // flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        racket-minimal =
          (import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          }).racket-minimal;
        default = self.packages.${system}.racket-minimal;
      };
    });
}
