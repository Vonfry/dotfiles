{ appimage-run }:

appimage-run.override {
  extraPkgs = pkgs: with pkgs; [
    fuse # used by pcloud
  ];
}
