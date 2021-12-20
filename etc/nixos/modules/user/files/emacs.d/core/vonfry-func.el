;;; core/core-func.el -*- lexical-binding: t; -*-
;; autoload function in core.

(defun vonfry/insert-current-date ()
  (interactive)
  (insert (current-time-string)))

(provide 'vonfry-func)
