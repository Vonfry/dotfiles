;;; browser packages -*- lexical-binding: t -*-
;;

(use-package eww
  :custom
  (browse-url-browser-function 'browse-url-generic)
  (browse-url-generic-program (getenv "BROWSER"))
  (url-configuration-directory (expand-file-name "url/" vonfry-cache-dir))
  (url-cache-directory (expand-file-name "url" vonfry-cache-dir))
  :general
  (nmap-at
    "w"   '(:ignore t :which-key "browse")
    "w w" 'eww
    "w W" 'browse-url-generic
    "w g" '+browse/switch-emacs
    "w G" '+browse/switch-generic))
