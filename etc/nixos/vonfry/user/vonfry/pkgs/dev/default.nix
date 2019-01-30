pkgs:

with import (dirOf <nixos-config> + /vonfry/libs);
builtins.foldl' (x: y: x ++ import y pkgs) [] (matchFiles ./. "[^\\.].*\\.nix" [ ./default.nix ])
