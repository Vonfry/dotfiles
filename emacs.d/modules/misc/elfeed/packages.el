;;; elfeed packages -*- lexical-binding: t -*-
;;

;(defun +elfeed-general-build-hook (pkg &rest args)
;  (when (string= pkg "elfeed")
;    (straight--fix-org-function "org")))
;(add-to-list 'straight-use-package-prepare-functions #'+elfeed-general-build-hook)
(package! elfeed
  :custom
  (elfeed-db-directory (expand-file-name "elfeed/db" vonfry-local-dir))
  (elfeed-enclosure-directory (expand-file-name "elfeed/enclosure" vonfry-local-dir))
  :hook
  (evil-mode . (lambda ()
    (evil-set-initial-state 'elfeed-search-mode 'emacs)
    (evil-set-initial-state 'elfeed-show-mode   'emacs)))
  :general
  ("C-x w" 'elfeed)
  (+mmap-at-def
    "f" 'elfeed))
