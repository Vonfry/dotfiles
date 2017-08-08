;;; cc packages -*- lexical-binding: t -*-
;;
;; Use rtags to jump and use irony to do completion and error check. And use EBrowse to make a class graph.

(vonfry|packages!
  rtags

  irony-mode
  company-irony
  flycheck-irony
  irony-eldoc

	disaster

  function-args
  cmake-mode
  cmake-font-lock)
