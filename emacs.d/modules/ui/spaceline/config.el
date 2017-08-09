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

(vonfry|use-package! spaceline-all-the-icons
  :after spaceline
  :init
  (custom-set-variables
    '(powerline-text-scale-factor 1.2)
    '(spaceline-all-the-icons-separator-type 'none))
  :config
  (spaceline-all-the-icons-theme)
  (spaceline-all-the-icons--setup-package-updates)
  (spaceline-all-the-icons--setup-git-ahead)
  (spaceline-all-the-icons--setup-neotree))

