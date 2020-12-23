;;; core/core-func.el -*- lexical-binding: t; -*-
;; autoload function in core.

(defun vonfry/insert-current-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%S +0800")))

(provide 'vonfry-func)
