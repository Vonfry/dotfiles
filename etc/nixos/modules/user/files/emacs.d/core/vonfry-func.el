;;; core/core-func.el -*- lexical-binding: t; -*-
;; autoload function in core.


(defalias #'plist-delete #'vonfry--plist-delete)

(defun vonfry-read-passwd (name)
  "read passwd from a gpg file."
  (let ((passwdLn (shell-command-to-string
                   (expand-file-name (concat name ".gpg") vonfry-passwd-dir))))
    (car (split-string passwdLn))))

(defun vonfry/insert-current-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S +0800")))

(provide 'vonfry-func)
