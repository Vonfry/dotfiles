;;; bib packages -*- lexical-binding: t -*-
;;

(package! ebib
  :custom
  (ebib-filters-default-file (expand-file-name "ebib/filters" vonfry-cache-dir))
  (ebib-file-associations '(("pdf" . "zathura")))
  :config
  (advice-add #'ebib :before #'+bib/switch-dir-current)
  :hook
  ((evil-mode . (lambda ()
    (evil-set-initial-state 'ebib-index-mode  'emacs)
    (evil-set-initial-state 'ebib-entry-mode  'emacs)
    (evil-set-initial-state 'ebib-log-mode    'emacs)
    (evil-set-initial-state 'ebib-string-mode 'emacs)))
   ((bibtex-mode LaTeX-mode) . +bib/switch-dir-current))
  :general
  (:keymaps '(LaTeX-mode-map org-mode-map)
    "C-&" 'ebib-insert-citation)
  (+mmap-mode-bib-def
    "e" 'ebib
    "d" '+bib/switch-dir-current)
  (+mmap-mode-org-def
    "["   '(nil :which-key "bib")
    "[ [" 'ebib
    "[ {" '+bib/switch-dir-current
    "[ }" '+bib/switch-dir
    "[ (" '+bib/switch-dir-from-search-dir
    "[ &" 'ebib-insert-citation
    "[ -" '+bib/switch-insert-single-or-multiple)
  (+mmap-mode-tex-def
    "[ [" 'ebib
    "[ {" '+bib/switch-dir-current
    "[ }" '+bib/switch-dir
    "[ (" '+bib/switch-dir-from-search-dir
    "[ &" 'ebib-insert-citation
    "[ -" '+bib/switch-insert-single-or-multiple))
