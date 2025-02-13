{
  description = "Custom nixpkgs overlay collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        isDarwin = builtins.match ".*-darwin" system != null;
        racketOverlay = import ./overlays/racket.nix;
        overlays = if isDarwin then [ racketOverlay ] else [ ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        legacyPackages = pkgs;
        packages = {
          inherit (pkgs) racket-minimal;
        };
      }
    );
}
