{
  source,
  importNpmLock,
  buildNpmPackage,
}:


buildNpmPackage {
  pname = "web-scout-mcp";
  version = "0-unstable-${source.date}";

  src = source.src;

  npmDeps = importNpmLock { npmRoot = source.src; };

  npmConfigHook = importNpmLock.npmConfigHook;
}
