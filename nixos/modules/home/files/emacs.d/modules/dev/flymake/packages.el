;;; flymake/packages.el --- -*- lexical-binding: t -*-
;;

(use-package flymake
  :hook (prog-mode . flymake-mode)
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "Q n" 'flymake-goto-next-error
    "Q p" 'flymake-goto-prev-error
    "Q b" 'flymake-show-buffer-diagnostics
    "Q p" 'flymake-show-project-diagnostics))

(use-package flymake-collection :after flymake)
