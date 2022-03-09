;;; dirvish packages -*- lexical-binding: t -*-

(use-package dirvish
  :custom
  (dirvish-cache-dir (expand-file-name "dirvish" vonfry-cache-dir))
  (dirvish-header-style nil)
  :config
  (dirvish-override-dired-mode 1)
  :general
  (nmap-leader
    "D" 'dirvish
    "d" 'dirvish-dired))
