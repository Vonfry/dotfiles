;;; elfeed/packages.el --- -*- lexical-binding: t -*-
;;

(use-package elfeed
  :custom
  (elfeed-db-directory (expand-file-name "elfeed/db" vonfry-local-dir))
  (elfeed-enclosure-directory (expand-file-name "elfeed/enclosure" vonfry-local-dir))
  (easy-jekyll-url "https://vonfry.name")
  (easy-jekyll-image-directory (expand-file-name "static/images" easy-jekyll-basedir))
  :init
  (load +feed-local-file t t)
  :general
  ("C-x w" 'elfeed)
  (nmap-at
    "f"   'elfeed
    "F"   '(nil :whik-hcey "feed")
    "F u" 'elfeed-search-fetch))

(use-package elfeed-org
  :custom
  (rmh-elfeed-org-files (list (expand-file-name "feeds.org" vonfry-custom-dir)))
  :config
  (elfeed-org))
