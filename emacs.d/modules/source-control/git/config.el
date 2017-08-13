;;; git packages -*- lexical-binding: t -*-

(vonfry|use-package! magit
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-version-control 'magit-status)
  :config
  (vonfry-system-sets '(darwin (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)]))))))

(vonfry|use-package! git-commit)
(vonfry|use-package! magit-popup)
(vonfry|use-package! with-editor)
(vonfry|use-package! gitconfig-mode)
(vonfry|use-package! gitignore-mode)
(vonfry|use-package! gitattributes-mode)

(vonfry|use-package! magit-gitflow
  :after magit
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

(vonfry|use-package! evil-magit)
