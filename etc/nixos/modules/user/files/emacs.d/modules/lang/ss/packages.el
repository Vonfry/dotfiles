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
   "' RET" 'ess-eval-buffer-from-beg-to-here
   "' b"   'ess-eval-buffer
   "' f"   'ess-eval-function)
  (vmap-leader :keymaps 'ess-mode-map
    "RET" 'ess-eval-region))

(use-package ess-r-mode
  :hook (ess-r-mode . eglot-ensure)
  :general
  (nmap-mode :keymaps 'ess-r-mode-map
    "R" ess-dev-map)
  :ensure nil)


(use-package ess-view-data :after ess
  :general
  (nmap-mode :keymaps 'ess-mode-map
    "v p" 'ess-view-data-print
    "v f" ' ess-view-data-filter
    "v s" 'ess-view-data-select
    "v S" 'ess-view-data-unselect
    "v g" 'ess-view-data-group
    "v G" 'ess-view-data-ungroup
    "v m" 'ess-view-data-mutate
    "v ," 'ess-view-data-slice
    "v l" 'ess-view-data-wide2long
    "v L" 'ess-view-data-long2wide
    "v u" 'ess-view-data-update
    "v r" 'ess-view-data-reset
    "v i" 'ess-view-data-unique
    "v c" 'ess-view-data-count
    "v a" 'ess-view-data-summarise
    "v o" 'ess-view-data-overview
    "v g" 'ess-view-data-goto-page
    "v j" 'ess-view-data-next-page
    "v k" 'ess-view-data-preious-page
    "v <" 'ess-view-data-first-page
    "v >" 'ess-view-data-last-page
    "v #" 'ess-view-data-page-number
    "v w" 'ess-view-data-save))
