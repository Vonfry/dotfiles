;;; irc config -*- lexical-binding: t -*-
;;

(custom! +irc-local-file (expand-file-name "irc.el" vonfry-local-dir)
  "A local config for irc, loads by `load'. It can be missing. "
  :type 'file
  :group 'vonfry-modules)
