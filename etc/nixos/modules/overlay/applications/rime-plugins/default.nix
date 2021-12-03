{ pkgs }:

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

  srcs = [
    (fetchFromGitHub rec {
      owner = "rime";
      repo = "rime-prelude";
      rev = "4001edf96791bbb5663573ba79ba4b1e9c0b8626";
      sha256 = "6PfOZu3HlPxcO1s7E5RfiBYYcVKWRDLSaTzs2h9VEtI=";
      name = "prelude";
    })
    (fetchFromGitHub rec {
      owner = "rime";
      repo = "rime-cangjie";
      rev = "8dfad9e537f18821b71ba28773315d9c670ae245";
      sha256 = "029kw9nx6x0acg4f0m8wj1ziqffffhy9yyj51nlx17cnia0qcrby";
      name = "cangjie";
    })
    (fetchFromGitHub rec {
      owner = "KyleBing";
      repo = "rime-wubi86-jidian";
      rev = "5107e8354e1f2c3f43faedf2eb3be566fe00ffff";
      sha256 = "xociF0vMJI8W2U2MkhoZT0zX4HHf3RNR5xjLwMeQxts=";
      name = "wubi86-jidian";
    })
    (fetchFromGitHub rec {
      owner = "gkovacs";
      repo = "rime-japanese";
      rev = "189f5e57198ff392518a901ab748beb0b44254f2";
      sha256 = "0cx30f6sknlg35hcrpsiik0pgkdpbfxyiwxc14p94njrr7r5r3k1";
      name = "japanese";
    })
  ];

  gen = src:
    let
      name = getAttr "name" src;
      value = wrap src;
    in { "${name}" = value; };

  pack = with lib;
    foldr recursiveUpdate {} (map gen srcs);

in pack
