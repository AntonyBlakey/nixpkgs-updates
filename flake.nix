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

        # Import all overlay files
        racketOverlay = import ./overlays/racket.nix;

        # Combine overlays conditionally
        overlays = (if isDarwin then [ racketOverlay ] else [ ]);

        # Create modified nixpkgs
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        # Export the full modified nixpkgs
        legacyPackages = pkgs;

        # Also export specific packages for convenience
        # packages = {
        #   inherit (pkgs) racket-minimal;
        # };
      }
    );
}
