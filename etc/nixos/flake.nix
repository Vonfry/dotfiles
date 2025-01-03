{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      emacs-overlay,
      flake-utils,
      nix-index-database,
      impermanence,
      disko,
      sops-nix,
    }@flakes:
    let
      overlay = import ./modules/overlay;
      flakeSpecialConfig =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [
            overlay
            emacs-overlay.overlay
          ];
          nix = {
            package = pkgs.nixVersions.stable;
            channel.enable = false;
            nixPath = [
              "nixos-config=${./.}"
              "nixpkgs=${nixpkgs}"
            ];
            extraOptions = ''
              flake-registry = /etc/nix/registry.json
              experimental-features = nix-command flakes
            '';
          };
          _module.args = {
            inherit flakes;
          };
        };
      flakeOutputs = flake-utils.lib.eachDefaultSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          ghcWith = pkgs.ghc.withPackages (p: [ p.nvfetcher ]);
        in
        {
          formatter = pkgs.nixfmt-rfc-style;
          devShell = pkgs.mkShell {
            packages = [
              ghcWith
              pkgs.nvchecker
            ];
          };
        }
      );
      hmSharedModules = _: {
        home-manager.sharedModules = [
          nix-index-database.hmModules.nix-index
          sops-nix.homeManagerModules.sops
        ];
      };
      nixosOutputs = {
        nixosConfigurations.vonfry = nixpkgs.lib.nixosSystem {
          modules = [
            flakeSpecialConfig
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            hmSharedModules
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
          ];
        };
      };
    in
    flakeOutputs // nixosOutputs // { inherit overlay; };
}
