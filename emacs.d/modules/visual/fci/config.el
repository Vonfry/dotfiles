;;; fci config -*- lexical-binding: t -*-

(vonfry|use-package! fill-column-indicator
  :config
  (custom-set-variables '(fci-rule-column vonfry-text-width))
  (defun +fci-auto-mode ()
    (if (> (window-width) fci-rule-column)
      (fci-mode 1)
      (fci-mode 0)))
  (defun +fci-prog-mode-settings ()
    (turn-on-fci-mode)
    (when show-trailing-whitespace
      (set (make-local-variable 'whitespace-style) '(face trailing))
      (whitespace-mode 1)))
  (add-hook 'prog-mode-hook '+fci-prog-mode-settings)
  (add-hook 'after-change-major-mode-hook '+fci-auto-mode)
  (add-hook 'window-configuration-change-hook '+fci-auto-mode))
