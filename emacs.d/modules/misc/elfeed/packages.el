;;; elfeed packages -*- lexical-binding: t -*-
;;

;(defun +elfeed-general-build-hook (pkg &rest args)
;  (when (string= pkg "elfeed")
;    (straight--fix-org-function "org")))
;(add-to-list 'straight-use-package-prepare-functions #'+elfeed-general-build-hook)
(package! elfeed
  :hook
  (evil-mode . (lambda ()
    (evil-set-initial-state 'elfeed-search-mode 'emacs)
    (evil-set-initial-state 'elfeed-show-mode   'emacs)))
  :general
  ("C-x w" 'elfeed)
  (+mmap-at-def
    "f" 'elfeed))

(package! elfeed-org
  :disabled
  :after elfeed org
  :custom (rmh-elfeed-org-files (list +elfeed-org-files))
  :config
  (elfeed-org))
