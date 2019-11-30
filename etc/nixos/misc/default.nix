{ config, pkgs, ...}:

{
  imports =
    [./teamviewer.nix
      ./font.nix
      ./sound.nix
    ];
}
