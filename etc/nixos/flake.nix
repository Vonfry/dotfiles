{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, home-manager, emacs-overlay, flake-utils
    }@flakes:
    let
      overlay = import ./modules/overlay;
      flakeSpecialConfig = { pkgs, ... }: {
        nixpkgs.overlays = [
          overlay
          emacs-overlay.overlay
        ];
        nix = {
          package = pkgs.nixFlakes;
          registry = {
            sys.flake = nixpkgs;
            nixpkgs.flake = nixpkgs;
            nixos.flake = nixpkgs;
          };
          channel.enable = false;
          nixPath = [ "nixos-config=${./.}" "nixpkgs=${nixpkgs}" ];
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
          devShell = pkgs.mkShell { packages = [ ghcWith pkgs.nvchecker ]; };
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
    in flakeOutputs // nixosOutputs // { inherit overlay; };
}
