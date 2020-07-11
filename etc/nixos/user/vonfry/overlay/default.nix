{ pkgs
, callPackage
, python3
, unstable ? import <nixpkgs-unstable> { overlays = [ ]; }
}:
{
  python = callPackage ./development/python/python { python = python3; };
  ruby = callPackage ./development/ruby/ruby { };
  hie = callPackage ./development/haskell/hie { };
  xmonad = callPackage ./applications/window-managers/xmonad { };
}
