;;; rainbow-mode config -*- lexical-binding: t -*-

(use-package! rainbow-mode
  :config
  (add-hook 'prog-mode-hook 'rainbow-mode))
