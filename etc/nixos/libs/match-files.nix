path: matchExp: exclude: 
# Only use this function to match files not under vcs.

let 
  dirFiles = builtins.readDir path;
  isMatch = fileName: builtins.match matchExp fileName != null;
  isExclude = fileName: 
    builtins.any 
      (epath:
        (builtins.match
	  ".*/${builtins.replaceStrings ["."] ["\\."] fileName}$" 
	  (toString epath))
	!= null)
      exclude;
  is = fileName: isMatch fileName && ! isExclude fileName;
  matchedFiles = builtins.filter is (builtins.attrNames dirFiles);
in map (f: path + "/${f}") matchedFiles
