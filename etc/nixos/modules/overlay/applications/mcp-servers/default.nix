{
  sources,
  importNpmLock,
  buildNpmPackage,
}:

{
  web-scout = import ./web-scout.nix {
    inherit
      importNpmLock
      buildNpmPackage
      ;
    source = sources.web-scout-mcp;
  };
}
