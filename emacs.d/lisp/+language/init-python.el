(require-package 'helm-pydoc)
(require-package 'anaconda-mode)
(require-package 'company-anaconda)
(require-package 'pip-requirements)
(require-package 'live-py-mode)
(defun vonfry/setup-python-mode ()
  (require 'live-py-mode)
  (setq python-shell-interpreter "python3")
  ; TODO waiting for working with jedi
  ; (anaconda-mode)
  ; (anaconda-eldoc-mode)
  ; (eval-after-load "company"
  ;  '(add-to-list 'company-backends 'company-anaconda))
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'python-mode
        "'"  'live-py-mode
        "."  'anaconda-mode-find-definitions
        "hh" 'anaconda-mode-show-doc
        "ga" 'anaconda-mode-find-assignments
        "gb" 'anaconda-mode-go-back
        "gu" 'anaconda-mode-find-references
        "hd" 'helm-pydoc)))
  (semantic-mode)
  (ggtags-mode 1)
  (ycmd-mode))
(add-hook 'python-mode-hook 'vonfry/setup-python-mode)

(require 'pip-requirements)

(provide 'init-python)
