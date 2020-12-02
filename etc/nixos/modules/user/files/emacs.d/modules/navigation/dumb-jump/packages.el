;;; dumb-jump packages -*- lexical-binding: t -*-
;;

(package! dumb-jump
  :general
  (+mmap-prog-def
    "." 'xref-goto-xref
    "," 'xref-pop-marker-stack
    ">" 'xref-find-apropos
    "[" 'xref-find-definitions
    "{" 'xref-find-references
    "(" 'info-xref
    "?" 'info-xref-docstrings)
  :hook (xref-backend-functions . dumb-jump-xref-activate)
  :custom
  (dumb-jump-selector 'ivy))
