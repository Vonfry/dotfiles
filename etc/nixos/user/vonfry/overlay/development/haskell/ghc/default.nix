{ ghc }:

ghc.withPackages (p: with p; [ aeson mtl containers dhall vector text bytestring
                               lens transformers optparse-applicative req
                             ])
