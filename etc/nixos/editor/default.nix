{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim neovim
    emacs
    editorconfig-core-c
  ];
  services.emacs.install = true;
}
