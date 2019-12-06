{ callPackage, python3, unstable }:

{
  python = callPackage ./development/python/python { python = python3; };
  rubyPkgs = callPackage ./development/ruby/self-pkgs { };
  hie = callPackage ./development/haskell/hie { };
  xmonad = callPackage ./applications/window-managers/xmonad { };
  fira-code-symbols = callPackage ./data/fonts/fira-code-symbols
                                  { fira-code = unstable.fira-code; };
}
