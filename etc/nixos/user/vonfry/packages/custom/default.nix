{ callPackage, python3 }:

{
  python = callPackage ./development/python/python { python = python3; };
  rubyPkgs = callPackage ./development/ruby/self-pkgs { };
  hie = callPackage ./development/haskell/hie { };
  xmonad = callPackage ./applications/window-managers/xmonad { };
}
