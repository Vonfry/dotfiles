{ pkgs }:

with pkgs;
with lib;

let
  wrap = import ./wrap.nix { inherit runCommand; };

  srcs = [
    (fetchFromGitHub rec {
      owner = "rime";
      repo = "rime-cangjie";
      rev = "d0f6f521ec049166ada29085434126be175f6439";
      sha256 = "029kw9nx6x0acg4f0m8wj1ziqffffhy9yyj51nlx17cnia0qcrby";
      name = "cangjie";
    })
    (fetchFromGitHub rec {
      owner = "KyleBing";
      repo = "rime-wubi86-jidian";
      rev = "b362d2ca5ecf1e7c4d94c46e8510c0f4c6b80862";
      sha256 = "12cvh9d3adiz0flj0071w9nc18zki3prnfwzyv9xkxzjwdcf8kd1";
      name = "wubi86-jidian";
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
