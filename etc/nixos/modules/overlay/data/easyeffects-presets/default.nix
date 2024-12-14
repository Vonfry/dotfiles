{ sources, callPackage }:

{
  easypulse = callPackage ./easypulse.nix { inherit sources; };
  bundy01 = callPackage ./bundy01.nix { inherit sources; };
}
