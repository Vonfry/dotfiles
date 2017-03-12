(require-package 'ggtags)
(defun vonfry/create-ctags-file ()
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key
        "." 'gtags-find-tag-dwim))) ;; default keybinding is with M- in evil insert mode.
  (shell-command "ctags -R --fields=+latinKS --extra=+qf ."))
(add-hook 'evil-local-mode-hook
  (lambda () (evil-leader/set-key "r" 'vonfry/create-ctags-file)))


(provide 'init-tags)
