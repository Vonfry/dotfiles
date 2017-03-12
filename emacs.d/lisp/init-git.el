(when (require-package 'magit)
  (setq-default magit-diff-refine-hunk t)

  ;; Hint: customize `magit-repo-dirs' so that you can use C-u M-F12 to
  ;; quickly open magit on any one of your projects.
  (global-set-key [(meta f12)] 'magit-status)
  (global-set-key (kbd "C-x g") 'magit-status)
  (global-set-key (kbd "C-x M-g") 'magit-dispatch-popup))

(with-eval-after-load 'magit
  (add-hook 'magit-popup-mode-hook 'no-trailing-whitespace))

(when *is-a-mac*
  (with-eval-after-load 'magit
    (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)])))))

(provide 'init-git)
