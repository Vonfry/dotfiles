;;; rainbow-mode config -*- lexical-binding: t -*-

(vonfry|use-package! rainbow-mode
  :config
  (add-hook 'prog-mode-hook 'rainbow-mode))
