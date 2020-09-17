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
   "\"" 'ess-interrupt)
  (+mmap-ss-def
   "' b"   'ess-eval-buffer
   "' f"   'ess-eval-function
   "RET"   'ess-eval-line
   "S-RET" 'ess-eval-buffer-from-beg-to-here))

(package! ess-r-mode
  :hook lsp
  :ensure nil)
