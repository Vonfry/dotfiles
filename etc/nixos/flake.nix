{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, home-manager
            , emacs-overlay, unstable, flake-utils
            }@flakes:
    let
      overlay = import ./modules/overlay;
      flakeSpecialConfig = { pkgs, ... }: {
        nixpkgs.overlays = [
          overlay
          emacs-overlay.overlay
          (s: p: {
            unstable = import unstable {
              inherit (p.hostPlatform) system;
              inherit (pkgs) config;
            };
          })
        ];
        nix = {
          package = pkgs.nixFlakes;
          registry = {
            sys.flake = nixpkgs;
            sys-unstable.flake = unstable;
            nixpkgs.flake = nixpkgs;
            nixpkgs-unstable.flake = unstable;
            nixos.flake = nixpkgs;
            nixos-unstable.flake = unstable;
          };
          extraOptions = ''
               flake-registry = /etc/nix/registry.json
               experimental-features = nix-command flakes
             '';
        };
        _module.args = { inherit flakes; };
      };
      flakeOutputs = flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ghcWith = pkgs.ghc.withPackages (p: with p; [ p.nvfetcher ]);
        in {
          devShell = pkgs.mkShell {
            packages = [ pkgs.nix-prefetch ghcWith pkgs.nvchecker ];
          };
        });
      nixosOutputs = {
        nixosConfigurations.vonfry = nixpkgs.lib.nixosSystem {
          modules = [
            flakeSpecialConfig
            home-manager.nixosModules.home-manager
            ./configuration.nix
          ];
        };
      };
    in flakeOutputs // nixosOutputs // {
      inherit overlay;
    };
}
