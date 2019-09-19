{ lib, ghc, useSystem ? true, useLatest ? false, versions ? [] }:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  ghcVersionList = builtins.splitVersion ghc.version;
  ghcVersionToString = builtins.foldl' (x: y: x + y) "" ghcVersionList;
  ghcVersionKey = "ghc${ghcVersionToString}";
  versionList = versions
    ++ (if useSystem then [ ghcVersionKey ] else [])
    ++ (if useLatest then [ lib.last (lib.attrValues versions) ] else []);
  selector = p: builtins.foldl' (a: b: a // b) {} (map (v: { ${v} = p.${v}; }) versionList);
in all-hies.selection { selector = selector; }
