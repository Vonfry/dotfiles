;;; spaceline packages -*- lexical-binding: t -*-
;;

(package! doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-python-executable nil)
  (doom-modeline-mu4e nil)
  (doom-modeline-irc nil))
