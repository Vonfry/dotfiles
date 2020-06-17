{ config, pkgs, ... }:

{

  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  environment = {
    systemPackages = with pkgs; [ ant-theme ];

    "gtk-2.0/gtkrc" = ''
    gtk-icon-theme-name = "Ant"
    gtk-theme-name = "Ant"
    gtk-font-name = "Source Han Sans CN 11"
    '';
    "gtk-3.0/settings.ini" = ''
    [Settings]
    gtk-icon-theme-name = Ant
    gtk-theme-name = Ant
    gtk-font-name = Source Han Sans CN 11
    '';
    # "xdg/Trolltech.conf" # for qt5
  };
}
