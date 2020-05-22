;;; latex func -*- lexical-binding: t -*-
;;

(fun! +bib/switch-ref (path)
  (interactive "fbib file: ")
  (eval `(custom-set! bibtex-completion-bibliography ,path)))
