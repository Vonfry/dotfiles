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
      repo = "rime-prelude";
      rev = "3de303ffaa731dba07b0462ce59f4767e1219ad2";
      sha256 = "0g7a0bla58rh1v3md59k6adk185pilb4z8i2i0pqdl4nwqp40n2p";
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
      rev = "a007585b3f80739dcedbea1bee2549ac28832709";
      sha256 = "0sbbm854si2mb47bn6dgb5bzxrvpc71bg3v0kckmpycdby7yv1j8";
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
