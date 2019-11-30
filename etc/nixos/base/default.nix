{ config, pkgs, lib, ... }:

{
  nix.nixPath = lib.mkOptionDefault [
    "nixos-vonfry-lib=/etc/nixos/lib"
  ];
  i18n = {
    consoleFont = "hack-11";
    consoleKeyMap = "dvorak-programmer";
    defaultLocale = "en_US.UTF-8";
    consolePackages = with pkgs; [ hack-font ];
  };

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [ sudo openssl cacert pciutils ];

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
