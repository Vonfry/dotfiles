;;; irc config -*- lexical-binding: t -*-
;;

(defcustom +irc-local-config-file
  (expand-file-name "dotfiles/emacs/irc" (getenv "CLOUDDISK_DIR"))
  "irc private config file."
  :group 'vonfry-module)
