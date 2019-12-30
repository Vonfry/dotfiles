;;; w3m func -*- lexical-binding: t -*-
;;

(fun! +browse/switch-emacs ()
  (interactive)
  (setq browse-url-browser-function 'w3m-browse-url))

(fun! +browse/switch-generic ()
  (interactive)
  (setq browse-url-browser-function 'browse-url-generic))
