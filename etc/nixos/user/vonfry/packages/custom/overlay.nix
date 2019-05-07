self: super:

with self;
{
  vonfryPython = callPackage ./dev-lang/python { python = python3 };
  vonfryRuby = callPackage ./dev-lang/ruby { };
  vonfryHie = callPackage ./dev-haskell/hie { };
  vonfryXmonad = callPackage ./x11-wm/xmonad { };
}
