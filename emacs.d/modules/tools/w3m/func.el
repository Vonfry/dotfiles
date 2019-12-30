;;; w3m func -*- lexical-binding: t -*-
;;

(fun! +browse/switch-emacs ()
  (custom-set-variables '(browse-url-browser-function #'w3m-browse-url)))

(fun! +browse/switch-generic ()
  (custom-set-variables '(browse-url-browser-function #'browse-url-default-browser)))
