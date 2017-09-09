;;; indent-guide config -*- lexical-binding: t -*-

(use-package! indent-guide
  :diminish indent-guide-mode
  :config
  (add-hook 'prog-mode-hook 'indent-guide-mode))
