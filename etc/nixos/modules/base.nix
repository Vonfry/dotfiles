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
      package = pkgs.nixFlakes;
      optimise.automatic = true;
      trustedUsers = [ "root" "@wheel" ];
      buildCores = 0;
      maxJobs = mkDefault "auto";
      gc = {
        automatic = mkDefault true;
        options = "--delete-older-than 14d";
        dates = "Sun 19:00";
      };
      extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
        flake-registry = /etc/nix/registry.json
      '';

      binaryCachePublicKeys = lib.mkBefore [
        "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      binaryCaches = lib.mkBefore [
        "https://nixos-cn.cachix.org"
        "https://nix-community.cachix.org"
      ];
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
      sudo = {
        enable = true;
        extraConfig = mkBefore ''
          Defaults timestamp_timeout=30
          Defaults env_keep += "*_proxy *_PROXY"
        '';
        wheelNeedsPassword = mkDefault true;
      };
      pam = rec {
       enableSSHAgentAuth = mkDefault true;
       services.sudo.sshAgentAuth = mkDefault enableSSHAgentAuth;
      };
    };

    system.stateVersion = "21.11";
  };
}
