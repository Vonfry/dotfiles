;;; elfeed packages -*- lexical-binding: t -*-
;;

(package! elfeed
  :disabled
  :general ("C-x w" 'elfeed)
  :general
  ;; set elfeed in custom or local files and load it by yourself.
  ;;
  ;; :config
  ;; (setq elfeed-feeds
  ;;   '(("http://nullprogram.com/feed/" blog emacs)
  ;;      "http://www.50ply.com/atom.xml"  ; no autotagging
  ;;     ("http://nedroid.com/feed/" webcomic)))
  ;;
  )

(package! elfeed-org
  :disabled
  :after elfeed org
  :custom (rmh-elfeed-org-files (list +elfeed-org-files))
  :config
  (elfeed-org))
