{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, home-manager, emacs-overlay, unstable }:
    let
      localSystem = "x86_64-linux";
      overlay = import ./modules/overlay;
      nixpkgsOverlaysConfig = { pkgs, ... }: {
        nixpkgs.overlays = [
          overlay
          emacs-overlay.overlay
          (s: p: {
            unstable = import unstable {
              inherit localSystem;
              inherit (pkgs) config;
            };
          })
        ];
      };
    in {
      inherit overlay;
      nixosConfigurations.vonfry = nixpkgs.lib.nixosSystem {
        system = localSystem;
        modules = [
          nixpkgsOverlaysConfig
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };
    };
}
