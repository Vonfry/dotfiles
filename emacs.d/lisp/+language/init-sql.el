(require-package 'sql-indent)
(defun vonfry/setup-sql-mode ()
  (require 'sql-indent))

(add-hook 'sql-mode-hook 'vonfry/setup-javascript-mode)

(provide 'init-sql)
