;;; gnus packages -*- lexical-binding: t -*-
;;

;; gnus is a good client for nntp protocol, mail, and feed client, but I want to
;; divide these function to different tools. And gnus read mail as news reader
;; which is not suit for me. I want to manage my mail to move them into
;; different folder for archive or mark as important. The same reson for
;; feed. One of other important reasons is gnus' document is not good for me to
;; check. Perhaps I will use this for mail or feed someday. At last, gnus is not
;; support local db files. For example, elfeed and mu are built a db for their
;; content to quick search, which is not supported by gnus. Of crouse, gnus can
;; use the third part such as notmuch for searching, but if I use gnus with
;; imap4 to get mail, it cannot work. Gnus' cache is only for articles.
(package! gnus
  :hook
  (gnus-group-mode . gnus-topic-mode)
  :custom
  (gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B (%c) %s%)\n")
  (gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M")))
  (gnus-group-line-format "%M%S%p%P%5y:%B %G\n")
  (gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references)
  (gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date))
  (gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\”]\”[#’()]")
  (gnus-sum-thread-tree-false-root "")
  (gnus-sum-thread-tree-indent " ")
  (gnus-sum-thread-tree-leaf-with-other "├► ")
  (gnus-sum-thread-tree-root "")
  (gnus-sum-thread-tree-single-leaf "╰► ")
  (gnus-sum-thread-tree-vertical "│")
  (gnus-article-browse-delete-temp t)
  (gnus-treat-strip-trailing-blank-lines 'last)
  (gnus-keep-backlog 'nil)
  (gnus-summary-display-arrow nil)
  (gnus-mime-display-multipart-related-as-mixed t)
  (gnus-auto-select-first nil)
  (smiley-style 'medium)
  (gnus-keep-backlog '0)
  (gnus-startup-file (expand-file-name "newsrc" vonfry-local-dir))
  (gnus-init-file +gnus-local-file)
  (nnrss-directory (expand-file-name "nnrss" vonfry-local-dir))
  (gnus-check-new-newsgroups nil)
  (gnus-save-newsrc-file nil)
  (gnus-read-newsrc-file nil)
  (gnus-use-cache t)
  (gnus-cache-directory (expand-file-name "gnus" vonfry-cache-dir))
  :general
  (+mmap-at-def
    "n" 'gnus))
