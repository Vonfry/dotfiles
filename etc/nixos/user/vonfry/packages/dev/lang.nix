{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
in
with pkgs; [
  zeal

  glibcInfo
  clang-tools

  haskellPackages.dhall
  haskellPackages.hoogle
  haskellPackages.stylish-haskell
  cabal2nix
  hie

  rustup
  rls

  rubyPkgs

  doxygen

  coq

  tectonic
  poppler
  pandoc

  solargraph
  ctags

  httpstat
  mycli
  pgcli
  asciinema
]
