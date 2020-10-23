{ config, lib, pkgs, ... }:


with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      xclip
      alacritty
      dunst libnotify
      vonfryPackages.unstable.ant-dracula-theme
      breeze-icons
    ];

    services.xbanish.enable = true;

    services.dbus.packages = with pkgs; [ gnome3.dconf ];

    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "dvp";
      autorun = true;

      libinput = {
        enable = true;
        accelProfile = "flat";
      };

      displayManager.sddm = {
        enable = true;
        theme = "Ant-Dracula";
      };

      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
    };
  };
}
