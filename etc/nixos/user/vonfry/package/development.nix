{ pkgs, customPkgs, ... }:

let
    hie = customPkgs.hie;
    rubyPkgs = customPkgs.rubyPkgs;
    pythonPkgs = customPkgs.python;
in with pkgs;
[ cloc
  patchelf
  binutils-unwrapped
  llvmPackages.clang llvm lldb
  cmake gnumake

  bear

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
  carnix

  pythonPkgs

  rubyPkgs
  solargraph

  doxygen

  coq

  poppler
  pandoc

  ctags

  sqlite
  mysql
  postgresql
  redis

  httpstat
] ++ lib.optional (!stdenv.isDarwin)
[ texlive.combined.scheme-full
  zeal
]
