;;; spaceline packages -*- lexical-binding: t -*-
;;

(package! spaceline
  :disabled
  :init
  (require 'spaceline-config)
  :config
  (require 'spaceline-segments)
  (custom-set-variables
    '(powerline-default-separator nil))
  (spaceline-spacemacs-theme)
  (spaceline-compile)
  (spaceline-info-mode)
  )

(package! spaceline-all-the-icons
  :disabled
  :after spaceline
  :custom
  (powerline-text-scale-factor 1.1)
  (spaceline-all-the-icons-separator-type 'none)
  :config
  (spaceline-all-the-icons-theme)
  (spaceline-all-the-icons--setup-package-updates)
  (spaceline-all-the-icons--setup-git-ahead)
  (spaceline-all-the-icons--setup-paradox))

(package! smart-mode-line
  :config
  (sml/setup))
