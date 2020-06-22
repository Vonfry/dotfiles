{ ... }:

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
}
