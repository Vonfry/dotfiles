;;; git packages -*- lexical-binding: t -*-
;;

(package! magit
  :general
  (nmap :prefix +nmap-leader
        +nmap-version-control 'magit-status)
  :config
  (vonfry-system-sets '(darwin (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)]))))))

(package! git-commit)
(package! magit-popup)
(package! with-editor)
(package! gitconfig-mode)
(package! gitignore-mode)
(package! gitattributes-mode)

(package! magit-gitflow
  :after magit
  :hook
  (magit-mode . turn-on-magit-gitflow))

(package! evil-magit)
