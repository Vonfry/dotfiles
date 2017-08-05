;;; fci config -*- lexical-binding: t -*-

(vonfry-use-package! 'fill-column-indicator
  :config
  (custom-set-variables '(fci-rule-column vonfry-text-width))
  (defun auto-fcl-mode ()
    (if (> (window-width) fci-rule-column)
      (fci-mode 1)
      (fci-mode 0)))
  (add-hook 'prog-mode-hook 'prog-mode-fci-settings)
  (add-hook 'after-change-major-mode-hook 'auto-fci-mode)
  (add-hook 'window-configuration-change-hook 'auto-fci-mode)
  )
