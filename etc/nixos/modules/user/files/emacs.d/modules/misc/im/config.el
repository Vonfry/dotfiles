;;; im/config.el --- -*- lexical-binding: t -*-
;;

(defcustom +irc-local-file (expand-file-name "irc.el" vonfry-custom-dir)
  "A local config for irc, loads by `load'.
It can be missing. "
  :type 'file
  :group 'vonfry-modules)

(defcustom +irc-connect-list '()
  "A list for irc connections.
It will be passed to `erc tls'."
  :type '(list (plist :key-type symbol :value-type sexp))
  :group 'vonfry-modules)
