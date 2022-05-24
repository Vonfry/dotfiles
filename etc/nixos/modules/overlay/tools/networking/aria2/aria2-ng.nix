{ sources, writeScriptBin }:

let

  ngSrc = sources.aria-ng.src;
  ariaNgOpen = writeScriptBin "aria2-ng-open" ''
    #!/usr/bin/env bash
    indexpath=${ngSrc}/index.html
    if [ -n "$BROWSER" ]; then
      $BROWSER $indexpath
    elif [ -n "$(type -P xdg-open)" ]; then
      xdg-open $indexpath
    else
        >&2 echo "No browser or xdg-open"
    fi
  '';
in {
  inherit ngSrc;
  open = ariaNgOpen;
}
