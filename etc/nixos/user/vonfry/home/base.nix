{ config, lib, ... }:

{
  imports = [ ./base.local.nix ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = import ../package/custom/overlays.nix;
  };
  home.file.".config/nix/nix.conf" = {
    executable = false;
    text = ''
      auto-optimise-store = true
      keep-outputs = true
      sandbox = false
    '';
  };
  # home.activation can not help me to boot the ln process for home.nix becasue
  # if the script can be done, the home.nix has been linked.
  home.activation = {
    shellActivation = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -f ${toString config.programs.zsh.dotDir} ]; then
      fi
    '';
  };
}
