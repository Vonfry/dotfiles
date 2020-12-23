;;; ss packages -*- lexical-binding: t -*-
;;

(use-package ess
  :custom
  (ess-use-flymake nil)
  (ess-smart-S-assign-key "$")
  (ess-use-ido nil)
  (ess-ido-flex-matching nil)
  (ess-use-auto-complete nil)
  (ess-history-directory (expand-file-name "ess/" vonfry-cache-dir))
  :general
  (nmap-leader :keymaps 'ess-mode-map
   "\""    'ess-interrupt
   "?"     'ess-help
   "RET"   'ess-eval-line
   "' b"   'ess-eval-buffer
   "' f"   'ess-eval-function
   "' r"   'ess-eval-region
   "' RET" 'ess-eval-buffer-from-beg-to-here))

(use-package ess-r-mode
  :hook lsp
  :ensure nil)
