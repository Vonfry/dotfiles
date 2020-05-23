;;; gnus packages -*- lexical-binding: t -*-
;;

;; gnus is a good client for nntp protocol, mail, and feed client, but I want to
;; divide these function to different tools. And gnus read mail as news reader
;; which is not suit for me. I want to manage my mail to move them into
;; different folder for archive or mark as important. The same reson for
;; feed. Another important reason is gnus' document is not good for me to
;; check. Perhaps I will use this for mail or feed someday.
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
