{ source, writeScriptBin }:

let
  ariaNgOpen = writeScriptBin "aria2-ng-open" ''
    #!/usr/bin/env bash
    indexpath=${source}/index.html
    if [ -n "$BROWSER" ]; then
      $BROWSER $indexpath
    elif [ -n "$(type -P xdg-open)" ]; then
      xdg-open $indexpath
    else
        >&2 echo "No browser or xdg-open"
    fi
  '';
in {
  ngSrc = source;
  open = ariaNgOpen;
}
