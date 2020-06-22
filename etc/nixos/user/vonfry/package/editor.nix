{ lib, pkgs, ... }:

with pkgs; [
  neovim vim
  editorconfig-core-c
] ++ lib.optional (!stdenv.isDarwin) [
  emacs
]
