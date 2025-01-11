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

        "/var/lib/nixos"

        "/var/lib/bluetooth"
        "/var/lib/systemd"
        "/var/lib/alsa"
        "/var/lib/libvirt"
        "/var/lib/os-prober"
        "/var/lib/swtpm-localca"

        "/var/lib/btrfs"
      ];
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          mode = "0600";
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key.pub";
          mode = "0600";
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          mode = "0600";
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key.pub";
          mode = "0600";
        }
      ];
    };
  };
}
