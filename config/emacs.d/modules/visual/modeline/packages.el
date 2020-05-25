;;; spaceline packages -*- lexical-binding: t -*-
;;

(package! doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom
  (doom-modeline-icon (display-graphic-p))
  (doom-modeline-lsp t)
  ; TODO fix (doom-modeline-gnus t)
  (doom-modeline-buffer-file-name-style 'file-name)
  (doom-modeline-irc t))
