with import <nixpkgs>;

{
  vonfryPython = callPackage ./dev-lang/python { python = python3 };
}
