;;; core/vonfry-func.el --- -*- lexical-binding: t; -*-
;;
;; autoload function in core.

(defun vonfry/insert-current-date ()
  "Insert current date time at point."
  (interactive)
  (insert (current-time-string)))

(defun vonfry/insert-zero-wide-space ()
  "Insert zero wide space char."
  (interactive)
  (insert-char #x00200B))

(provide 'vonfry-func)
