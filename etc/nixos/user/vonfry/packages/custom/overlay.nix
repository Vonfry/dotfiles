self: super:

with super;
{
  python = callPackage ./dev-lang/python { python = python3; };
  rubyPkgs = callPackage ./dev-ruby/self-pkgs { };
  hie = callPackage ./dev-haskell/hie { };
  xmonad = callPackage ./x11-wm/xmonad { };
}
