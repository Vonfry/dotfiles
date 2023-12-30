;;; core/vonfry-func.el --- -*- lexical-binding: t; -*-
;;
;; autoload function in core.

(defun vonfry/insert-current-date ()
  "Insert current date time at point."
  (interactive)
  (insert (current-time-string)))

(provide 'vonfry-func)
