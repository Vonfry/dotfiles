;;; cc packages -*- lexical-binding: t -*-
;;

(dolist (mode '(c-mode-hook c++-mode-hook))
  (add-hook mode 'lsp-deferred))

(use-package disaster
  :general
  (nmap-mode :keymaps '(c-mode-map c++-mode-map)
    "d" 'disaster))

;; this is used in all program lang
(use-package compile
  :ensure nil
  :custom
  (compilation-scroll-output t)
  (compilation-always-kill t))

(use-package cmake-mode
  :mode ("\\.cmake\\'" "CMakeLists\\.txt\\'")
  :hook
  (cmake-mode . (lambda ()
    (+company-set-backends-grouped '(company-cmake)))))

(use-package realgud-lldb
  :after realgud
  :general
  (nmap-mode :keymaps '(c-mode-map c++-mode-map)
    "R" 'lldb))
