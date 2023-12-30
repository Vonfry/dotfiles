;;; gnus/packages.el --- -*- lexical-binding: t -*-
;;

;; gnus is a good client for nntp protocol, mail, and feed client, but I want to
;; divide these function to different tools.
;; And gnus read mail as news reader which is not fit for me. It misses some
;; mail action for me. The big problem is to sync and move mail.
(use-package gnus
  :hook
  (gnus-group-mode . gnus-topic-mode)
  :custom
  (gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B (%c) %s%)\n")
  (gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M")))
  (gnus-group-line-format "%M%S%p%P%5y:%B %C\n")
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
  (gnus-summary-display-arrow nil)
  (gnus-mime-display-multipart-related-as-mixed t)
  (gnus-auto-select-first nil)
  (smiley-style 'medium)
  (gnus-check-new-newsgroups nil)
  (gnus-activate-level 4)
  (gnus-startup-file (expand-file-name "newsrc" vonfry-local-dir))
  (gnus-init-file +gnus-local-file)
  (nnrss-directory (expand-file-name "nnrss" vonfry-local-dir))
  (gnus-check-new-newsgroups nil)
  (gnus-save-newsrc-file nil)
  (gnus-read-newsrc-file nil)
  (gnus-use-cache 'passive)
  (gnus-cache-directory (expand-file-name "gnus" vonfry-cache-dir))
  (gnus-desktop-notify-function 'gnus-desktop-notify-exec)
  (gnus-group-sort-function 'gnus-group-sort-by-rank)
  (gnus-topic-sort-function 'gnus-topic-sort-groups-by-rank)
  (gnus-asynchronous t)
  (gnus-keep-backlog 50)
  (gnus-default-article-saver 'gnus-summary-save-in-file)
  (gnus-article-save-directory (expand-file-name "gnus/article"
                                                 vonfry-local-dir))
  (mm-text-html-render 'html2text)
  (nndraft-directory (expand-file-name "gnus/draft" vonfry-local-dir))
  :general
  (nmap-at
    "n" 'gnus))
