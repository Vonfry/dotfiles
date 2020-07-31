{ ghc }:

ghc.withPackages (p: with p; [ aeson mtl http containers dhall ])
