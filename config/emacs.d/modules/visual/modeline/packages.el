;;; spaceline packages -*- lexical-binding: t -*-
;;

(package! doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-icon (display-graphic-p))
  (doom-modeline-lsp t)
  (doom-modeline-gnus t)
  (doom-modeline-gnus-timer 0) ; use gnus desktop notify to check news
  (doom-modeline-buffer-file-name-style 'file-name)
  (doom-modeline-irc t))
