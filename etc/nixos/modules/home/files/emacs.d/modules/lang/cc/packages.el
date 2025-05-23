;;; cc/packages.el --- -*- lexical-binding: t -*-
;;

(dolist (mode '(c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook))
  (add-hook mode 'eglot-ensure))

(nmap-mode :keymaps '(c-mode-map c++-mode-map c-ts-mode-map c++-ts-mode-map)
  "h" 'ff-find-other-file
  "H" 'ff-find-related-file)

(use-package disaster
  :general
  (nmap-mode
    :keymaps '(c-mode-map c++-mode-map c-ts-mode-map c++-ts-mode-map)
    "d" 'disaster))

;; this is used in all program lang
(use-package compile
  :ensure nil
  :custom
  (compilation-scroll-output t)
  (compilation-always-kill t))
