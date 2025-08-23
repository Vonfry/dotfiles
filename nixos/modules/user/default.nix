{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.vonfry;
  userconfig = {
    users.motd = builtins.readFile ../home/files/motd;
    # FIXME userborn doesn't support subuid and subgid, but we need
    # them. Therefore, mutable one here so that it can work.
    users.mutableUsers = true;

    users.users.vonfry = {
      isNormalUser = true;
      uid = mkDefault 1000;
      description = "Vonfry";
      extraGroups = [
        "wheel"
        "podman"
      ];
      shell = pkgs.bash;

      hashedPasswordFile = config.sops.secrets.${cfg.secretsName.password}.path;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.vonfry = _: {
        imports = [ ../home/home.nix ];

        vonfry = {
          inherit (cfg) enable workspace;
        };
      };
    };
  };
in
{

  imports = [
    (mkAliasOptionModule
      [
        "vonfry"
        "homeConfiguration"
      ]
      [
        "home-manager"
        "users"
        "vonfry"
      ]
    )
    (mkAliasOptionModule
      [
        "vonfry"
        "userConfiguration"
      ]
      [
        "users"
        "users"
        "vonfry"
      ]
    )
    ./preservation.nix
    ./application.nix
    ./x.nix
    ./secrets.nix
  ];

  config = mkIf cfg.enable userconfig;
}
