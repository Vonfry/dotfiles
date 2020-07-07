{ callPackage, lib, ghc, useSystem ? true, useLatest ? false, versions ? [] }:

let
  all-hies = callPackage <all-hies> {};
  ghcVersionList = builtins.splitVersion ghc.version;
  ghcVersionToString = builtins.foldl' (x: y: x + y) "" ghcVersionList;
  ghcVersionKey = "ghc${ghcVersionToString}";
  versionList = versions
    ++ lib.optional useSystem ghcVersionKey
    ++ lib.optionals useLatest [ lib.last (lib.attrValues versions) ];
  selector = p: builtins.foldl' (a: b: a // b) {} (map (v: { ${v} = p.${v}; }) versionList);
in all-hies.selection { selector = selector; }
