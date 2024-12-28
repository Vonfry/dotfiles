{ config, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in
{
  config = mkIf cfg.enable {
    programs.fuse.userAllowOther = true;

    environment.persistence."/persistent" = {
      enable = true;
      hideMounts = true;
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

        "/var/lib/dhcpcd"
        "/var/db/dhcpcd"
      ];
      files = [
        "/etc/machine-id"
        "/var/lib/logrotate.status"

        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };
  };
}
