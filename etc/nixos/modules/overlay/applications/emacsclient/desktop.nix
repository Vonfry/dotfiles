{ lib, makeDesktopItem, emacs }:

let
 mimeTypes = [ # copy from emacs.desktop
      "text/english" "text/plain" "text/x-makefile" "text/x-c++hdr"
      "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc"
      "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript"
      "text/x-c" "text/x-c++"
    ];
  passthru = { inherit mimeTypes; };
  desktopItem = makeDesktopItem {
    name = "emacsclient";
    desktopName = "Emacs (Client)";
    genericName = "Text Editor";
    exec = "${emacs}/bin/emacsclient --no-wait --alternate-editor=emacs %F";
    mimeType= lib.concatStringsSep ";" (mimeTypes ++ [ "" ]);
    icon = "emacs";
    comment = "Emacsclient with default daemon and opened frame";
    categories = "Utility;TextEditor;";
    extraDesktopEntries = {
      "Keywords" = "Text;Editor;";
    };
  };
in desktopItem // { inherit passthru; }
