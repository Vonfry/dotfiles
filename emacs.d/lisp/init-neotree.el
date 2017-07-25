(require-package 'neotree)
;; set keyboard in evil-leader
(setq neo-smart-open t)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; work with projectile
(setq projectile-switch-project-action 'neotree-projectile-action)
;; work with evil
(add-hook 'neotree-mode-hook
  (lambda ()
    (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
    (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
    (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
    (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
    (define-key evil-normal-state-local-map (kbd "r") 'neotree-rename-node)))
(add-hook 'evil-local-mode-hook
  (lambda ()
    (evil-leader/set-key
        "n" 'neotree-toggle)))

(provide 'init-neotree)
