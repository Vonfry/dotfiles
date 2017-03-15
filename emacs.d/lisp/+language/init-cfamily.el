(require-package 'disaster)
(require-package 'cmake-mode)

(defun vonfry/setup-cfamily-mode ()
  (rainbow-turn-off)
  (require 'disaster)
  (require 'cc-mode)
  (require 'compile)
  (semantic-mode)
  (c-toggle-auto-newline 1)
  (setq c-basic-offset 4)
  (add-hook 'evil-local-mode-hook
   (lambda ())
      (evil-leader/set-key ;; for mode
        "D" 'disaster))
  (setq
   ;; use gdb-many-windows by default when `M-x gdb'
   gdb-many-windows t
   ;; Non-nil means display source file containing the main routine at startup
   gdb-show-main t)
  (ggtags-mode 1)
  (ycmd-mode))

(add-hook 'c-mode-hook 'vonfry/setup-cfamily-mode)
(add-hook 'c++-mode-hook 'vonfry/setup-cfamily-mode)
(add-hook 'objective-c-mode-hook 'vonfry/setup-cfamily-mode)

(provide 'init-cfamily)
