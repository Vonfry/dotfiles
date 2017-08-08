;;; spaceline config -*- lexical-binding: t -*-

(vonfry|use-package! spaceline
  :init
  (require 'spaceline-config)
  :config
  (require 'spaceline-segments)
  (custom-set-variables
    '(powerline-default-separator nil))
  (spaceline-spacemacs-theme)
  (spaceline-compile)
  (spaceline-info-mode)
  (spaceline-helm-mode))

;; TODO more setting
(vonfry|use-package! spaceline-all-the-icons
  :after spaceline
  :config
  (spaceline-all-the-icons-theme)
  (spaceline-all-the-icons--setup-package-updates)
  (spaceline-all-the-icons--setup-git-ahead)
  (spaceline-all-the-icons--setup-neotree))

