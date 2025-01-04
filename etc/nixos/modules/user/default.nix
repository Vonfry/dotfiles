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
    users.mutableUsers = false;

    users.users.vonfry = {
      isNormalUser = true;
      uid = mkDefault 1000;
      description = "Vonfry";
      extraGroups = [
        "wheel"
        "libvirtd"
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
    ./impermanence.nix
    ./definitions.nix
    ./application.nix
    ./x.nix
  ];

  config = mkIf cfg.enable userconfig;
}
