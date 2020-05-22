;;; gnus packages -*- lexical-binding: t -*-
;;

(package! gnus
  :config
  (custom-set! gnus-startup-file
                 (expand-file-name "newsrc" vonfry-local-dir)
               gnus-init-file +gnus-local-file)
  :hook
  (gnus-group-mode . gnus-topic-mode)
  :custom
  (nnrss-directory (expand-file-name "nnrss" vonfry-local-dir))
  (gnus-check-new-newsgroups nil)
  (gnus-save-newsrc-file nil)
  (gnus-read-newsrc-file nil)
  (gnus-use-cache t)
  (gnus-cache-directory (expand-file-name "gnus" vonfry-cache-dir))
  :general
  (+mmap-at-def
    "n" 'gnus))
