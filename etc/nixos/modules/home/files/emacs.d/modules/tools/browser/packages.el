;;; browser/packages.el --- -*- lexical-binding: t -*-
;;

(use-package eww
  :custom
  (browse-url-browser-function 'browse-url-default-browser)
  (browse-url-secondary-browser-function 'browse-url-generic)
  (browse-url-generic-program (getenv "BROWSER"))
  (eww-bookmarks-directory vonfry-local-dir)
  (url-configuration-directory (expand-file-name "url/" vonfry-cache-dir))
  (url-cache-directory (expand-file-name "url" vonfry-cache-dir))
  :general
  (nmap-at
    "w w" 'eww
    "w m" 'eww-list-bookmarks
    "w f" 'eww-open-file
    "w n" 'eww-open-in-new-buffer
    "w b" 'eww-list-buffers
    "w o" 'browse-url))
