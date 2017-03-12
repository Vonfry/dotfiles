(require-package 'js2-mode)
(require-package 'json-mode)
(require-package 'web-beautify)

(defun vonfry/setup-javascript-mode ()
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'js2-mode
        "w"  'js2-mode-toggle-warnings-and-errors
        "zc" 'js2-mode-hide-element
        "zo" 'js2-mode-show-element
        "zr" 'js2-mode-show-all
        "ze" 'js2-mode-toggle-element
        "zF" 'js2-mode-toggle-hide-functions
        "zC" 'js2-mode-toggle-hide-comments)
      (evil-leader/set-key-for-mode 'js2-mode  "=" 'web-beautify-js)
      (evil-leader/set-key-for-mode 'json-mode "=" 'web-beautify-js)
      (evil-leader/set-key-for-mode 'web-mode  "=" 'web-beautify-html)
      (evil-leader/set-key-for-mode 'css-mode  "=" 'web-beautify-css)))
  (require 'json-mode)
  (ggtags-mode 1)
  (ycmd-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'js2-imenu-extras-mode)
(add-hook 'js2-mode-hook 'vonfry/setup-javascript-mode)


(provide 'init-javascript)
