;;; bib packages -*- lexical-binding: t -*-
;;

(package! ebib
  :custom
  (ebib-filters-default-file (expand-file-name "ebib/filters" vonfry-cache-dir))
  (ebib-file-associations (vonfry-system-sets
                           (darwin '(("pdf" . "open")))
                           (gnu/linux '(("pdf" . "zathura")))))
  :hook
  (evil-mode . (lambda ()
    (evil-set-initial-state 'ebib-index-mode  'emacs)
    (evil-set-initial-state 'ebib-entry-mode  'emacs)
    (evil-set-initial-state 'ebib-log-mode    'emacs)
    (evil-set-initial-state 'ebib-string-mode 'emacs)))
  :general
  (+mmap-mode-org-def
    "(" 'ebib
    "*" '+bib/switch-dir
    ")" '+bib/switch-dir-from-search-dir
    "[" 'ebib-insert-citation)
  (+mmap-mode-tex-def
    "(" 'ebib
    "*" '+bib/switch-dir
    ")" '+bib/switch-dir-from-search-dir
    "[" 'ebib-insert-citation))

(package! ivy-bibtex
  :after ivy
  :custom
  (bibtex-completion-bibliography '("./refs/refs.bib"))
  (bibtex-completion-library-path '("./refs"))
  :general
  (+mmap-mode-tex-def
    "%" '+bib/switch-ref
    "&" 'ivy-bibtex)
  (+mmap-mode-org-def
    "%" '+bib/switch-ref
    "&" 'ivy-bibtex))
