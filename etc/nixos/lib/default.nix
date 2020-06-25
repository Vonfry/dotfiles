args@{ lib, ... }:

let
  libFiles = [ ];
  callImport = path: (import path) args;
  libImports = map callImport libFiles;
  mkLib = imports: builtins.foldl' (x: y: x // y) {} imports;
in {
  lib = mkLib libImports;
}
