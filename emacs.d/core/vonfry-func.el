;;; core/core-func.el -*- lexical-binding: t; -*-
;; autoload function in core.


(autoload! 'vonfry/insert-current-date "date" t)
(autoload! 'vonfry/compile-init-files "compile" t)

(defalias #'plist-delete #'vonfry--plist-delete)

(provide 'vonfry-func)
