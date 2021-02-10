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
  (nmap-mode :keymaps 'ess-mode-map
   "\""    'ess-interrupt
   "?"     'ess-help)
  (nmap-leader :keymaps 'ess-mode-map
   "\""    'ess-interrupt
   "?"     'ess-help
   "RET"   'ess-eval-line
   "' b"   'ess-eval-buffer
   "' f"   'ess-eval-function
   "' RET" 'ess-eval-buffer-from-beg-to-here)
  (vmap-leader :keymaps 'ess-mode-map
    "' r" 'ess-eval-region))

(use-package ess-r-mode
  :hook (ess-r-mode . lsp)
  :ensure nil)
