;;; git packages -*- lexical-binding: t -*-

(vonfry|use-package! magit
  :config
  (vonfry-system-sets '(darwin (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)]))))))

(vonfry|use-package! magit-gitflow
  :after magit
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

(vonfry|use-package! evil-magit)
