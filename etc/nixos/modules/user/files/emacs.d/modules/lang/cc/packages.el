;;; cc packages -*- lexical-binding: t -*-
;;

(dolist (mode '(c-mode-hook c++-mode-hook))
  (add-hook mode 'eglot-ensure))

(nmap-mode :keymaps '(c-mode-map c++-mode-map)
  "h" 'ff-find-other-file
  "H" 'ff-find-related-file)

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
  :mode ("\\.cmake\\'" "CMakeLists\\.txt\\'"))

(use-package realgud-lldb
  :after realgud
  :general
  (nmap-mode :keymaps '(c-mode-map c++-mode-map)
    "R" 'lldb))
