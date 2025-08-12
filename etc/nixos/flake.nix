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
    preservation.url = "github:nix-community/preservation";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-servers = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyproject-nix = {
      url = "github:nix-community/pyproject.nix";
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
      preservation,
      disko,
      sops-nix,
      mcp-servers,
      pyproject-nix,
      ...
    }@flakes:
    let
      flake-overlays = self: super: { inherit pyproject-nix; };
      overlay = import ./modules/overlay;
      flakeSpecialConfig =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [
            flake-overlays
            overlay
            emacs-overlay.overlay
            mcp-servers.overlays.default
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
          formatter = pkgs.nixfmt;
          devShell = pkgs.mkShell {
            packages = [
              ghcWith
              pkgs.nvchecker
              pkgs.sops
            ];
          };
        }
      );
      hmSharedModules = _: {
        home-manager.sharedModules = [
          nix-index-database.homeModules.nix-index
          sops-nix.homeManagerModules.sops
        ];
      };
      nixosOutputs = {
        nixosModule = {
          imports = [
            flakeSpecialConfig
            preservation.nixosModules.preservation
            home-manager.nixosModules.home-manager
            hmSharedModules
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            (self + "/modules/")
          ];
        };
        nixosConfigurations.vonfry = nixpkgs.lib.nixosSystem {
          modules = [
            self.nixosModule
            ./configuration.nix
          ];
        };
      };
    in
    flakeOutputs // nixosOutputs // { inherit overlay; };
}
