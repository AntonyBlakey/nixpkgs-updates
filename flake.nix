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
    let
      mkPackage =
        system:
        (import nixpkgs {
          inherit system;
          overlays = [ (import ./overlays) ];
        }).racket-minimal;
    in
    flake-utils.lib.eachDefaultSystem (system: {
      packages.default = mkPackage system;
      packages.racket-minimal = mkPackage system;
      # For devbox direct reference
      default = mkPackage system;
      racket-minimal = mkPackage system;
    });
}
