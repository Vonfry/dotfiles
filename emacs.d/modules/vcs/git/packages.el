;;; git packages -*- lexical-binding: t -*-
;;

(package! magit
  :general
  (+nmap-magit-def "-" 'magit-status)
  :config
  (vonfry-system-sets (darwin (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)]))))))

(package! git-commit :after magit)
(package! transient :after magit
  :custom
  (transient-history-file (expand-file-name "transient/history.el" vonfry-cache-dir))
  (transient-values-file (expand-file-name "transient/values.el" vonfry-cache-dir))
  (transient-levels-file (expand-file-name "transient/levels.el" vonfry-cache-dir)))
(package! with-editor :after magit)
(package! gitconfig-mode :after magit)
(package! gitignore-mode :after magit)
(package! gitattributes-mode :after magit)

(package! magit-gitflow
  :after magit
  :hook
  (magit-mode . turn-on-magit-gitflow))

(package! evil-magit :after magit evil)

(package! gitlab-ci-mode)
