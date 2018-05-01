;;; indent-guide config -*- lexical-binding: t -*-

(use-package! indent-guide
  :diminish indent-guide-mode
  :hook (prog-mode . indent-guide-mode))
