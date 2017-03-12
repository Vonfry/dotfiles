(when (require-package 'projectile)
  (add-hook 'after-init-hook 'projectile-global-mode)

  (setq projectile-tags-command "ctags -R --fields=+latinKS --extra=+qf .")
  ;; Shorter modeline
  (with-eval-after-load 'projectile
    (setq-default
     projectile-mode-line
     '(:eval
       (if (file-remote-p default-directory)
           " Pr"
         (format " Pr[%s]" (projectile-project-name)))))))


(provide 'init-projectile)
