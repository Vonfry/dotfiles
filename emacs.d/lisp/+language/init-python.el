(require-package 'helm-pydoc)
; (require-package 'anaconda-mode)
; (require-package 'company-anaconda)
(require-package 'pip-requirements)
(require-package 'live-py-mode)
(defun vonfry/setup-python-mode ()
  (require 'live-py-mode)
  (setq python-shell-interpreter "python3")
  (anaconda-mode t)
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'python-mode
        "'"  'live-py-mode
        "hh" 'anaconda-mode-show-doc
        "ga" 'anaconda-mode-find-assignments
        "gb" 'anaconda-mode-go-back
        "gu" 'anaconda-mode-find-references
        "hd" 'helm-pydoc)))
  (semantic-mode)
  (ggtags-mode 1)
  (ycmd-mode))

(add-hook 'python-mode-hook 'vonfry/setup-python-mode)
(add-to-list 'auto-mode-alist
  `(,(rx ".pip" string-end) . pip-requirements-mode))
(add-to-list 'auto-mode-alist
  `(,(rx "requirements" (zero-or-more anything) ".txt" string-end) . pip-requirements-mode))
(add-to-list 'auto-mode-alist
  `(,(rx "requirements.in") . pip-requirements-mode))

(provide 'init-python)
