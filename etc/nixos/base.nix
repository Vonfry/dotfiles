{ config, pkgs, lib, ... }:

let
  localFiles = [ ./base.local.nix ];
in
{
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Hack-11";
    keyMap = "dvorak-programmer";
    packages = with pkgs; [ hack-font kbdKeymaps.dvp ];
  };

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [
    lnav

    sudo
    gnutls
    cacert
    pciutils

    exfat
  ];

  security.sudo.enable = true;

  nix.optimise.automatic = true;
  nix.trustedUsers = [ "root" "@wheel" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = import ./user/vonfry/overlay/overlays.nix;
  };

  services = {
    syslog-ng.enable = true;
    logrotate.enable = true;
  };

  system.stateVersion = "20.03";

  imports = localFiles;
}
