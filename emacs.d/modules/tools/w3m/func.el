;;; w3m func -*- lexical-binding: t -*-
;;

(fun! +browse/switch-emacs ()
  (setq browse-url-browser-function 'w3m-browse-url))

(fun! +browse/switch-generic ()
  (setq browse-url-browser-function 'browse-url-default-browser))
