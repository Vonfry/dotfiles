;;; git packages -*- lexical-binding: t -*-

(use-package! magit
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-version-control 'magit-status)
  :config
  (vonfry-system-sets '(darwin (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)]))))))

(use-package! git-commit)
(use-package! magit-popup)
(use-package! with-editor)
(use-package! gitconfig-mode)
(use-package! gitignore-mode)
(use-package! gitattributes-mode)

(use-package! magit-gitflow
  :after magit
  :init
  (defvar magit-gitflow-popup-key "C-x C-g")
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

(use-package! evil-magit)
