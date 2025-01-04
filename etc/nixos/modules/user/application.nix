{ ... }:

{
  programs = {
    weylus.users = [ "vonfry" ];
  };

  # NixOS per-user profile also uses this.
  environment.pathsToLink = [ "/share/easyeffects" ];
}
