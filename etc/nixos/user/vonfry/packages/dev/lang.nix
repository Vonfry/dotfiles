{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
in
with pkgs; [
  zeal

  glibcInfo
  clang-tools

  ghc
  cabal-install
  haskellPackages.dhall
  haskellPackages.hoogle
  haskellPackages.stylish-haskell
  cabal2nix
  hie

  rustup
  rls

  ruby bundler bundix ## rbenv; not! use nix instead.
  rubyPkgs

  python3Full

  doxygen

  coq

  nodejs

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
