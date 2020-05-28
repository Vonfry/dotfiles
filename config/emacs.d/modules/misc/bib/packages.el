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
  (:keymaps '(LaTeX-mode-map org-mode-map)
    "C-&" 'ebib-insert-citation)
  (+mmap-mode-org-def
    "["   '(nil :which-key "bib")
    "[ (" 'ebib
    "[ =" '+bib/switch-dir
    "[ )" '+bib/switch-dir-from-search-dir
    "[ [" 'ebib-insert-citation)
  (+mmap-mode-tex-def
    "[ (" 'ebib
    "[ =" '+bib/switch-dir
    "[ )" '+bib/switch-dir-from-search-dir
    "[ [" 'ebib-insert-citation))
