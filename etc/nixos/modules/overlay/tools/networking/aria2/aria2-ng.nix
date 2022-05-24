{ sources, writeScriptBin, runCommandNoCC, unzip }:

let

  ngSrc = sources.aria-ng.src;
  ngDrv = runCommandNoCC "aria-ng" { buildInputs = [ unzip ]; } ''
    unzip ${ngSrc}
    mkdir $out
    cp index.html $out/index.html
  '';
  ariaNgOpen = writeScriptBin "aria2-ng-open" ''
    #!/usr/bin/env bash
    indexpath=${ngDrv}/index.html
    if [ -n "$BROWSER" ]; then
      $BROWSER $indexpath
    elif [ -n "$(type -P xdg-open)" ]; then
      xdg-open $indexpath
    else
        >&2 echo "No browser or xdg-open"
    fi
  '';
in {
  aria-ng = ngDrv;
  open = ariaNgOpen;
}
