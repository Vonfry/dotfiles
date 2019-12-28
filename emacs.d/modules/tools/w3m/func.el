;;; w3m func -*- lexical-binding: t -*-
;;

(fun! +browse/switch-emacs ()
  (browse-url-browser-function #'w3m-browse-url))

(fun! +browse/switch-generic ()
  (browse-url-browser-function #'browse-url-default-browser))
