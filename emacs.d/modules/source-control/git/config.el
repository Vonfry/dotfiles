;;; git packages -*- lexical-binding: t -*-

(vonfry|use-package! magit
  :config
  (add-hook 'magit-popup-mode-hook 'no-trailing-whitespace)
  (vonfry-system-sets '(darwin (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)]))))))

(vonfry|use-package! evil-magit)
