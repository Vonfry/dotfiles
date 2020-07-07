{ config, pkgs, lib, ... }:

let
  localFiles = [ ./base.local.nix ];
in
{
  i18n = {
    consoleFont = "Hack-11";
    consoleKeyMap = "dvorak-programmer";
    defaultLocale = "en_US.UTF-8";
    consolePackages = with pkgs; [ hack-font ];
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

  nix.optimise.automatic = true;
  nix.trustedUsers = [ "root" "@wheel" ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = import ./user/vonfry/package/custom/overlays.nix;
  };

  services = {
    syslog-ng.enable = true;
    logrotate.enable = true;
  };

  imports = localFiles;
}
