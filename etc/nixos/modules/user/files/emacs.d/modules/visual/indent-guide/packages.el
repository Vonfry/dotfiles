;;; indent-guide packages -*- lexical-binding: t -*-
;;

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'bitmap)
  (highlight-indent-guides-responsive 'top))
