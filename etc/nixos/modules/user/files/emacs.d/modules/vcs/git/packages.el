;;; git packages -*- lexical-binding: t -*-
;;

(package! magit
  :general
  (+mmap-magit-def "-" 'magit-status))

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
  :custom
  (magit-gitflow-popup-key "C-c g")
  :hook
  (magit-mode . turn-on-magit-gitflow))

(package! gitlab-ci-mode)

(package! forge
  :after magit
  :custom
  (forge-database-file (expand-file-name "forge" vonfry-local-dir)))
