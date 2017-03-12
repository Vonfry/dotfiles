(defun vonfry/setup-shell-mode ()
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'sh-mode
        "\\" 'sh-backslash-region)))
  (with-eval-after-load 'company
    (push 'company-shell company-backends-sh-mode)))

(dolist (pattern '("\\.zsh\\'"
                   "zlogin\\'"
                   "zlogout\\'"
                   "zpreztorc\\'"
                   "zprofile\\'"
                   "zshenv\\'"
                   "zshrc\\'"))
  (add-to-list 'auto-mode-alist (cons pattern 'sh-mode)))
(add-hook 'sh-mode-hook 'vonfry/setup-shell-mode)
(provide 'init-shell)
