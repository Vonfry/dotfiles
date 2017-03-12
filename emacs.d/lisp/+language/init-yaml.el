(require-package 'yaml-mode)
(add-hook 'yaml-mode-hook
  (lambda ()
    (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(provide 'init-yaml)
