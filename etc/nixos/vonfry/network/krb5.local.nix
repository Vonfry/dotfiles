{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ krb5 heimdal ];
  krb5 = {
    enable = false;
    realms = {
      "NIXOS" = {
        admin_server = "nixos";
	kdc = "nixos";
      };
    };
    libdefaults = {
      default_realm = "NIXOS";
    };
    extraConfig = 
      ''
      [logging]
      kdc = FILE:/var/log/krb5kdc.log
      admin_server = FILE:/var/log/kadmin.log
      default = FILE:/var/log/krb5lib.log
      '';
  };
}
