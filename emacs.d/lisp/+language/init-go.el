(require-package 'go-mode)
(require-package 'go-guru)
(require-package 'go-eldoc)
(require-package 'company-go)

(defun vonfry/setup-go-mode ()
  (with-eval-after-load 'company
  (setq company-go-show-annotation t)
  (push 'company-go company-backends-go-mode)))
(add-hook 'go-mode-hook 'vonfry/setup-go-mode)

(provide 'init-go)
