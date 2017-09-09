;;; rainbow-delimiters config -*- lexical-binding: t -*-

(use-package! rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
