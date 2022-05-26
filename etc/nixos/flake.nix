{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, home-manager, emacs-overlay, unstable }@flakes:
    let
      localSystem = "x86_64-linux";
      overlay = import ./modules/overlay;
      flakeSpecialConfig = { pkgs, ... }: {
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

      pkgs = nixpkgs.legacyPackages.${localSystem};
      ghcWith = pkgs.ghc.withPackages (p: with p; [ p.nvfetcher ]);
    in {
      inherit overlay;
      nixosConfigurations.vonfry = nixpkgs.lib.nixosSystem {
        system = localSystem;
        modules = [
          flakeSpecialConfig
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };

      devShell.${localSystem} = pkgs.mkShell {
          packages = [ pkgs.nix-prefetch ghcWith ];
      };
    };
}
