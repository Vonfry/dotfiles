{ config, pkgs, ... }:

{
  i18n = {
    consoleFont = "hack-11";
    consoleKeyMap = "dvorak-programmer";
    defaultLocale = "en_US.UTF-8";
    consolePackages = with pkgs; [ hack-font ];
  };

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [ sudo ];

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services = {
    openssh =  {
      enable = true;
      allowSFTP = true;
      passwordAuthentication = false;
      permitRootLogin = "prohibit-password";
      extraConfig = 
        ''
        ClientAliveInterval 60
        ClientAliveCountMax 4
        '';
    };
    syslog-ng.enable = true;
    logrotate.enable = true;
  };

  security = {
    sudo.extraConfig = "Defaults timestamp_timeout=30 ";
    pam.enableSSHAgentAuth = true;
  };

  nix.optimise.automatic = true;

  imports = [ ./default.local.nix ]; # This file must be existed.
}
