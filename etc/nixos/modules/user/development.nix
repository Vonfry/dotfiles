{ ... }:

{
  users.users.vonfry = {
    # for rootless podman
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
}
