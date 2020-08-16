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
    sudo
    gnutls cacert
    pciutils usbutils inxi
    exfat

    lnav
    atop htop
    lm_sensors lsof
  ];

  security.sudo.enable = true;

  nix = {
    optimise.automatic = true;
    trustedUsers = [ "root" "@wheel" ];
    maxJobs = "auto";
    buildCores = 0;
  };


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
