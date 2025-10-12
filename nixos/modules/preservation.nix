{ config, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in
{
  options.vonfry.preservation.dir = mkOption {
    type = types.path;
    default = "/persistent";
    description = "The persistence directory";
  };

  imports = [
    (mkAliasOptionModule
      [
        "vonfry"
        "preservation"
        "root"
      ]
      [
        "preservation"
        "preserveAt"
        config.vonfry.preservation.dir
      ]
    )
    (mkAliasOptionModule
      [
        "vonfry"
        "preservation"
        "users"
      ]
      [
        "preservation"
        "preserveAt"
        config.vonfry.preservation.dir
        "users"
      ]
    )
    (mkAliasOptionModule
      [
        "vonfry"
        "preservation"
        "home"
      ]
      [
        "preservation"
        "preserveAt"
        config.vonfry.preservation.dir
        "users"
        "vonfry"
      ]
    )
  ];

  config = mkIf cfg.enable {
    preservation.enable = true;
    vonfry.preservation.root = {
      directories = [
        "/var/log"

        "/var/lib/bluetooth"
        "/var/lib/systemd"
        "/var/lib/alsa"
        "/var/lib/swtpm-localca"

        "/var/lib/btrfs"
      ];
      files = [
        {
          file = "/etc/machine-id";
          how = "symlink";
          configureParent = true;
          inInitrd = true;
        }
      ];
    };

    # A work round for systemd-machine-id-commit.
    # See github:nixos/nixpkgs#351151 and issues in preservation and
    # impermanence.
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    systemd.services.systemd-machine-id-commit = {
      unitConfig.ConditionPathIsMountPoint = [
        ""
        "/persistent/etc/machine-id"
      ];
      serviceConfig.ExecStart = [
        ""
        "systemd-machine-id-setup --commit --root /persistent"
      ];
    };
  };
}
