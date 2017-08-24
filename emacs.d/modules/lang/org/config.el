;;; orgmode config -*- lexical-binding: t -*-

(vonfry|use-package! org
  :config
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate))

(vonfry|use-package! org-bullets
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(vonfry|use-package! evil-org
  :after evil org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'org-mode-hook
    (lambda ()
      (evil-org-set-key-theme '(navigation insert textobjects additional)))))
