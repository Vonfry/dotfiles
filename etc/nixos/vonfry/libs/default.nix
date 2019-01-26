let 
  matchFiles = import ./matchFiles.nix;
  files = matchFiles ./. "^[^\\.].*\\.nix$" [ ./default.nix ];
  attrList =
    map 
      (f: { 
        name = (builtins.head (builtins.split "\\." (baseNameOf f)));
        value = import f; 
      }) 
      files;
in builtins.listToAttrs attrList
