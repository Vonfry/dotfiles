;;; rainbow-delimiters config -*- lexical-binding: t -*-

(vonfry-use-package! 'rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
