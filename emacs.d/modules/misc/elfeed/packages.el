;;; elfeed packages -*- lexical-binding: t -*-

(package! elfeed
  :disabled
  :general ("C-x w" 'elfeed)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-feed 'elfeed)
  ;;
  ;; set elfeed in custom or local files and load it by yourself.
  ;;
  ;; (setq elfeed-feeds
  ;;   '(("http://nullprogram.com/feed/" blog emacs)
  ;;      "http://www.50ply.com/atom.xml"  ; no autotagging
  ;;     ("http://nedroid.com/feed/" webcomic)))
  ;;
  )

(package! elfeed-org
  :disabled
  :after elfeed org
  :init
  (defcustom +elfeed-org-files (list (expand-file-name "feed.org" vonfry-local-dir))
    "elfeed-org-files save dir"
    :type '(list string)
    :group 'vonfry-modules)
  (custom-set-variables '(rmh-elfeed-org-files (list +elfeed-org-files)))
  :config
  (elfeed-org))
