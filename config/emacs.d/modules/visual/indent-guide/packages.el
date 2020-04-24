;;; indent-guide packages -*- lexical-binding: t -*-
;;

(package! highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-responsive 'top))
