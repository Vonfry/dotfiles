{ appimage-run }:

appimage-run.override {
  extraPkgs = pkgs: with pkgs; [
    # pcloud
    fuse
    glib
    gtk3
    gsettings-desktop-schemas
  ];
}
