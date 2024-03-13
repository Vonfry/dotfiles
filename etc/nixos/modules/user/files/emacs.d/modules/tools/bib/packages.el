;;; bib/packages.el --- -*- lexical-binding: t -*-
;;

(use-package ebib
  :custom
  (ebib-filters-default-file (expand-file-name "ebib/filters" vonfry-cache-dir))
  (ebib-file-associations '(("pdf" . "zathura")))
  (ebib-bibtex-dialect 'biblatex)
  (ebib-notes-storage 'multiple-notes-per-file)
  (ebib-notes-directory nil)
  (ebib-reading-list-file "reading.org")
  (ebib-notes-default-file "notes.org")
  (ebib-file-search-dirs '("."))
  :general
  (:keymaps '(LaTeX-mode-map org-mode-map)
    "C-{" 'ebib-insert-citation)
  (nmap-mode :keymaps 'bibtex-mode-map
    "E" 'ebib
    "e" '+bib/ebib-current)
  (nmap-mode :keymaps '(org-mode-map TeX-mode-map)
    "[ [" 'ebib
    "[ &" 'ebib-insert-citation)
  ;; These has confliction with evil
  (general-unbind ebib-log-mode-map
    :with nil
    "SPC" "S-SPC")
  (general-unbind ebib-strings-mode-map
    :with nil
    "SPC" "S-SPC")
  (general-unbind ebib-entry-mode-map
    :with nil
    "SPC" "S-SPC")
  (general-unbind ebib-index-mode-map
    :with nil
    "SPC" "S-SPC"))

(use-package org-ebib :ensure nil :after org)
