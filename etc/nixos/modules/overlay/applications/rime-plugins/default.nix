{
  lib,
  runCommandNoCC,
  sources,
}:

with lib;

let
  wrap =
    src:
    runCommandNoCC src.pname { } ''
      mkdir -p $out/share/rime
      cp ${src.src}/*.yaml $out/share/rime
      if [ -f ${src.src}/rime.lua ]; then
        cp ${src.src}/rime.lua $out/share/rime
      fi
    '';

  srcs = with sources; [
    rime-prelude
    rime-cangjie
    rime-wubi86-jidian
    rime-japanese
  ];

  gen =
    src:
    let
      name = removePrefix "rime-" src.pname;
      value = wrap src;
    in
    {
      "${name}" = value;
    };

  pack = with lib; foldr recursiveUpdate { } (map gen srcs);

in
pack
