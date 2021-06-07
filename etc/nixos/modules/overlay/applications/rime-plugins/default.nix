{ pkgs }:

with pkgs;
with lib;

let
  wrap = src:
    runCommand "rime-${src.name}" {} ''
      mkdir -p $out/share/rime
      cp ${src}/*.yaml $out/share/rime
      ${if src ? "extraRun" then src.extraRun else "" }
    '';

  srcs = [
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
      rev = "438d56d25ea1b0404e08b03ef7cc439b963080f3";
      sha256 = "0xzzbljv6vzxqafgk2knh414xjn3v15mldc47127lifs8gxkgn08";
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
