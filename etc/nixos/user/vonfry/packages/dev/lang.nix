{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
in
with pkgs; [
  glibcInfo

  haskellPackages.dhall
  haskellPackages.hoogle
  cabal2nix
  hie

  doxygen

  texlive.combined.scheme-basic
  poppler
  pandoc

  solargraph

  httpstat
  mycli
  pgcli
  asciinema
]
