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
    {
      # Standard flake outputs
      packages = flake-utils.lib.eachDefaultSystem (system: {
        racket-minimal = mkPackage system;
        default = self.packages.${system}.racket-minimal;
      });

      # Direct package access for devenv
      racket-minimal = mkPackage (builtins.head flake-utils.lib.defaultSystems);
    }
    //
      # Direct package access for devbox
      flake-utils.lib.eachDefaultSystem (system: {
        racket-minimal = mkPackage system;
      });
}
