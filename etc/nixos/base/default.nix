{ config, pkgs, lib, ... }:

{
  i18n = {
    consoleFont = "Hack-11";
    consoleKeyMap = "dvorak-programmer";
    defaultLocale = "en_US.UTF-8";
    consolePackages = with pkgs; [ hack-font ];
  };

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [ sudo gnutls cacert pciutils ];

  nix.optimise.automatic = true;

  imports =
    [ ./unmask.nix
      ./unmask.local.nix
      ./default.local.nix
      ./hdfmt.nix
      ./nix.nix
      ./log.nix
    ];
}
