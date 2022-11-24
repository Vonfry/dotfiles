{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    boot.tmpOnTmpfs = mkDefault true;

    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = mkDefault "dvorak-programmer";

    time.timeZone = mkDefault "Asia/Shanghai";

    environment.systemPackages = with pkgs; [
      gnutls cacert
      pciutils usbutils inxi
      exfat zstd

      lnav btop lsof

      file patch colordiff parallel
      ripgrep fd lsd
    ];

    nix = {
      optimise.automatic = true;
      settings = {
        trusted-users = [ "root" "@wheel" ];
        cores = 0;
        max-jobs = mkDefault "auto";
        auto-optimise-store = true;
        trusted-public-keys = [
          "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        substituters = lib.mkBefore [
          "https://nixos-cn.cachix.org"
          "https://nix-community.cachix.org"
        ];
      };
      gc = {
        automatic = mkDefault true;
        options = "--delete-older-than 14d";
        dates = "Sun 19:00";
      };
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
      '';

    };

    nixpkgs.config = import ./user/files/nixpkgs.nix;

    services = {
      dbus.enable = true;
      openssh =  {
        enable = mkDefault false;
        allowSFTP = mkDefault true;
        passwordAuthentication = mkDefault false;
        permitRootLogin = mkDefault "prohibit-password";
        extraConfig = ''
          ClientAliveInterval 60
          ClientAliveCountMax 4
        '';
      };
    };

    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        extraRules = [
          { groups = [ "wheel" ];
            setEnv = [ "http_proxy" "https_proxy" "all_proxy"
                       "HTTP_PROXY" "HTTPS_PROXY" "ALL_PROXY"
                     ]; }
        ];
        wheelNeedsPassword = mkDefault true;
      };
      pam = {
       enableSSHAgentAuth = mkDefault true;
      };
    };

    system.stateVersion = "22.11";
  };
}
