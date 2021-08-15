;;; git packages -*- lexical-binding: t -*-
;;

(use-package vc
  :custom
  (vc-follow-symlinks nil))

(use-package magit
  :general
  (nmap-leader "-" 'magit-status)
  (general-unbind magit-mode-map
    :with nil
    ;; These has confliction with evil
    "SPC" "S-SPC"))

(use-package git-commit)
(use-package transient
  :custom
  (transient-history-file (expand-file-name "transient/history.el" vonfry-cache-dir))
  (transient-values-file (expand-file-name "transient/values.el" vonfry-cache-dir))
  (transient-levels-file (expand-file-name "transient/levels.el" vonfry-cache-dir)))
(use-package with-editor)
(use-package gitconfig-mode)
(use-package gitignore-mode)
(use-package gitattributes-mode)

(use-package magit-gitflow
  :init
  (setq-default magit-gitflow-popup-key "C-c g")
  :hook
  (magit-mode . turn-on-magit-gitflow))

(use-package gitlab-ci-mode)

(use-package forge
  :custom
  (forge-database-file (expand-file-name "forge" vonfry-local-dir)))
