{ lib }:

with builtins; with lib;
{
  mkImportWith = path: lst: lst ++
    map (n: path + "/${n}")
        (attrNames (filterAttrs
                   (n: v: v != "directory" && isList (match "^.*\\.nix$" n))
                   (readDir path)));
}
