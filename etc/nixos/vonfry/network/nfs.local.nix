{ config, pkgs, ... }:

{
  services.nfs.server = { 
    enable = true;
    exports = 
      ''
      / 10.0.0.0/8(rw,fsid=0,no_subtree_check,all_squash,insecure,anonuid=0,anongid=0)
      /home/vonfry 10.0.0.0/8(rw,no_subtree_check,all_squash,insecure,anonuid=1000,anongid=1000)
      '';
  };
}
