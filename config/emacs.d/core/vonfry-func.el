;;; core/core-func.el -*- lexical-binding: t; -*-
;; autoload function in core.


(autoload! 'vonfry/insert-current-date "date" t)
(autoload! 'vonfry/compile-init-files "compile" t)

(alias #'plist-delete #'vonfry--plist-delete)

(fun! vonfry-read-passwd (name)
  "read passwd from a gpg file."
  (let ((passwdLn (shell-command-to-string
                   (expand-file-name (concat name ".gpg") vonfry-passwd-dir))))
    (car (split-string passwdLn))))

(provide 'vonfry-func)
