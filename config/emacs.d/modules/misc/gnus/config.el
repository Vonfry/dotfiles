;;; gnus config -*- lexical-binding: t -*-
;;

(custom! +gnus-local-file (expand-file-name "gnus.el" vonfry-local-dir)
  "A local file for gnus private config is loaded automaticly, which can be
 missing."
  :type 'file
  :group 'vonfry-modules)
