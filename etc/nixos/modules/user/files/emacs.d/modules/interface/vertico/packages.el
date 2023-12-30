;;; vertico/packages.el --- -*- lexical-binding: t -*-
;;

(use-package vertico
  :custom
  (vertico-count 20)
  (vertico-resize t)
  (vertico-cycle t)
  :config
  (vertico-mode))

(use-package vertico-quick
  :after vertico
  :ensure nil
  :custom
  (vertico-quick1 "aoeui")
  (vertico-quick2 "dhtns")
  :general
  (:keymaps 'vertico-map
    "C-'"  'vertico-quick-insert
    "C-\"" 'vertico-quick-exit))
