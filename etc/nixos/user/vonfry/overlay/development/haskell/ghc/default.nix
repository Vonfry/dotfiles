{ ghc }:

ghc.withPackages (p: with p; [ aeson mtl HTTP containers dhall vector text
                               bytestring ])
