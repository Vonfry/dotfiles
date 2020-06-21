args@{ pkgs, ... }:

{
  home.packages = (import ./package args);
}
