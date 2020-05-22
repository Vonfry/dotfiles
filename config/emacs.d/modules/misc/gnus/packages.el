;;; gnus packages -*- lexical-binding: t -*-
;;

(package! gnus
  :init
  (custom-set! gnus-startup-file
                 (expand-file-name "newsrc" vonfry-local-dir)
               gnus-init-file +gnus-locale-init)
  :custom
  (gnus-check-new-newsgroups nil)
  (gnus-save-newsrc-file nil)
  (gnus-read-newsrc-file nil)
  (gnus-use-t cache)
  (gnus-cache-directory (expand-file-name "gnus" vonfry-cache-dir)))
