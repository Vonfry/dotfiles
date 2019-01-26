{ config, pkgs, ... }:

{
  users.users.vonfry.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMpHbr9kE9gybnF7a9I8eb9Oa/1GEMj759MlSueRpXL1 vonfry314@gmail.com" ];
  security.sudo.extraConfig = "Defaults:vonfry timestamp_timeout=-1";
}
