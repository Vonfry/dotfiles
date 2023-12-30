;;; git/packages.el --- -*- lexical-binding: t -*-
;;

(use-package vc
  :custom
  (vc-follow-symlinks nil))

(use-package magit
  :general
  (nmap-leader "-" 'magit-status)
  (nmap-leader "_" 'magit-dispatch)
  (general-unbind magit-mode-map
    :with nil
    ;; These has confliction with evil
    "SPC" "S-SPC")
  :custom
  (transient-history-file (expand-file-name "transient/history.el" vonfry-cache-dir))
  (transient-values-file (expand-file-name "transient/values.el" vonfry-cache-dir))
  (transient-levels-file (expand-file-name "transient/levels.el" vonfry-cache-dir)))

(use-package git-modes)

(use-package forge
  :after magit
  :custom
  (forge-database-file (expand-file-name "forge" vonfry-local-dir)))
