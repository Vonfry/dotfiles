{ pkgs
, callPackage
, python3
, unstable ? import <nixpkgs-unstable> { overlays = [ ]; }
}:
{
  inherit unstable;
  python = callPackage ./development/python/python { python = python3; };
  ghc = callPackage ./development/haskell/ghc { };
  perl = callPackage ./development/perl/perl { };
  hie = callPackage ./development/haskell/hie { };
  xmonad = callPackage ./applications/window-managers/xmonad { };
}
