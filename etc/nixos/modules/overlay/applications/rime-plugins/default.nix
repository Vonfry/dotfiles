{ pkgs, sources }:

with pkgs;
with lib;

let
  wrap = src:
    runCommand "rime-${src.name}" {} ''
      mkdir -p $out/share/rime
      cp ${src}/*.yaml $out/share/rime
      if [ -f ${src}/rime.lua ]; then
        cp ${src}/rime.lua $out/share/rime
      fi
    '';

  srcs = with sources; [ rime-prelude rime-cangjie rime-wubi86-jidian
                         rime-japanese
                       ];

  gen = src:
    let
      name = removePrefix "rime-" (getAttr "pname" src);
      value = wrap src;
    in { "${name}" = value; };

  pack = with lib;
    foldr recursiveUpdate {} (map gen srcs);

in pack
