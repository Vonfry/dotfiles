{ sources, callPackage }:

{
  easypulse = callPackage ./easypulse.nix { inherit sources; };
  jackhack96 = callPackage ./jackhack96.nix { inherit sources; };
}
