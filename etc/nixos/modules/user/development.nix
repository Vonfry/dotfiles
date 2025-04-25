{ ... }:

{
  # for rootless podman
  # Only update-users-groups reads it. But userborn is now, we have to manual
  # create them.
  users.users.vonfry = {
    subUidRanges = [
      {
        startUid = 100000;
        count = 65535;
      }
    ];
    subGidRanges = [
      {
        startUid = 100000;
        count = 65535;
      }
    ];
  };

  # FIXME remove this when nixos module can generate it with below configs.
  environment.etc = {
    "subuid" = {
      mode = "0644";
      text = ''
        vonfry:100000:65535
      '';
    };
    subgid = {
      mode = "0644";
      text = ''
        vonfry:100000:65535
      '';
    };
  };
}
