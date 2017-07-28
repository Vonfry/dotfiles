;;; core/core-local.el -*- lexical-binding: t; -*-
;;
;; Set some emacs files to local path.

;;
;; Set some variables
;;
(defconst vonfry-local-path (expand-file-name "local" user-emacs-directory))
(defconst vonfry-custom-file (expand-file-name "custom.el" vonfry-local-path))

(custom-set-variables
  '(auto-save-list-file-prefix (expand-file-name "saves-" vonfry-local-path))
  '(custom-file vonfry-custom-file)
  )

(provide 'core-local)
