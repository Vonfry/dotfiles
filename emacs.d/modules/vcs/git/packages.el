;;; git packages -*- lexical-binding: t -*-
;;

(package! magit
  :general
  (nmap :prefix +nmap-leader
        +nmap-version-control 'magit-status)
  :config
  (vonfry-system-sets (darwin (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)]))))))

(package! git-commit :after magit)
(package! transient :after magit)
(package! with-editor :after magit)
(package! gitconfig-mode :after magit)
(package! gitignore-mode :after magit)
(package! gitattributes-mode :after magit)

(package! magit-gitflow
  :after magit
  :hook
  (magit-mode . turn-on-magit-gitflow))

(package! evil-magit :after magit evil)
