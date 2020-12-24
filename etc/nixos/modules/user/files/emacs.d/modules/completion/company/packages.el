;;; company packages -*- lexical-binding: t -*-
;;

(use-package company
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-limit 16)
  (company-minimum-prefix-length 4)
  (company-tooltip-flip-when-above t)
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil)
  (case-replace nil)
  (company-tooltip-offset-display 'lines)
  (company-backends `(,+company-default-backends
                      company-capf ; avoid lsp mode add it again
                      company-semantic))
  :general
  (:keymaps 'company-active-map
    "C-w"     nil  ; don't interfere with `evil-delete-backward-word'
    "C-n"     'company-select-next
    "C-p"     'company-select-previous
    "C-j"     'company-select-next
    "C-k"     'company-select-previous
    "C-h"     'company-show-doc-buffer
    "C-u"     'company-previous-page
    "C-d"     'company-next-page
    "C-s"     'company-filter-candidates
    "C-S-s"   'counsel-company
    "C-SPC"   'company-complete-common
    "TAB"     'company-complete-common-or-cycle
    [backtab] 'company-select-previous)
  (:keymaps 'company-search-map
    "C-n"    'company-select-next-or-abort
    "C-p"    'company-select-previous-or-abort
    "C-j"    'company-select-next-or-abort
    "C-k"    'company-select-previous-or-abort
    "C-s"    'company-filter-candidates
    [escape] 'company-search-abort)
  :config
  (global-company-mode 1))

(use-package company-quickhelp
  :after company
  :config
  (company-quickhelp-mode 1))

(use-package company-prescient
  :after company
  :custom
  (prescient-save-file (expand-file-name "prescient" vonfry-cache-dir))
  :hook
  (company-mode . company-prescient-mode)
  :config
  (prescient-persist-mode 1))
