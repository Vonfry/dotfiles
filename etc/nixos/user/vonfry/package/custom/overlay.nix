self: super:

with super;
{
  hie = callPackage ./development/haskell/hie { };
  fira-code-symbols = callPackage ./data/fonts/fira-code-symbols
                                  { fira-code = super.unstable.fira-code; };
}
