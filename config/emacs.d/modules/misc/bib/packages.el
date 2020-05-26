;;; bib packages -*- lexical-binding: t -*-
;;

(package! ebib
  :custom
  (ebib-filters-default-file (expand-file-name "ebib/filters" vonfry-cache-dir))
  (ebib-file-associations (vonfry-system-sets
                           (darwin '(("pdf" . "open")))
                           (gnu/linux '(("pdf" . "zathura"))))))

(package! ivy-bibtex
  :after ivy
  :custom
  (bibtex-completion-bibliography '("./refs/refs.bib"))
  (bibtex-completion-library-path '("./refs"))
  :general
  (+mmap-mode-tex-def
    "&" 'ivy-bibtex)
  (+mmap-mode-org-def
    "&" 'ivy-bibtex))
