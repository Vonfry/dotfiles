;;; ss packages -*- lexical-binding: t -*-
;;

(package! ess
  :custom
  (ess-use-flymake nil)
  (ess-smart-S-assign-key "$")
  (ess-use-ido nil)
  (ess-ido-flex-matching nil)
  (ess-use-auto-complete nil)
  (ess-history-directory (expand-file-name "ess/" vonfry-cache-dir))
  :general
  (+mmap-ss-def
   "'" 'ess-interrupt))

(package! ess-r-mode
  :hook lsp
  :ensure nil)
