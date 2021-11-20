{ fetchzip, writeScriptBin }:

let
  version = "1.2.3";
  ariaNg = fetchzip {
    url = "https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}-AllInOne.zip";
    sha256 = "0lx7xykq74xg64323bfqsar87d002rz25y7a03glaw6j8cj0hr1x";
    stripRoot = false;
  };

  ariaNgOpen = writeScriptBin "aria2-ng-open" ''
    #!/usr/bin/env bash
    indexpath=${ariaNg}/index.html
    if [ -n "$BROWSER" ]; then
      $BROWSER $indexpath
    elif [ -n "$(type -P xdg-open)" ]; then
      xdg-open $indexpath
    else
        >&2 echo "No browser or xdg-open"
    fi
  '';
in {
  ngSrc = ariaNg;
  open = ariaNgOpen;
}
