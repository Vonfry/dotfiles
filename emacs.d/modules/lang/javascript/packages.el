;;; javascript packages -*- lexical-binding: t -*-
;;

(package! js2-mode
  :mode ("\\.js\\'" . js2-mode)
  :interpreter "node"
  :hook (js2-mode . js2-imenu-extras-mode)
  :general
  (nmap :keymaps '(js-mode-map js2-mode-map)
    :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-jump-module 'js-find-symbol))

(package! lsp-javascript-typescript
  :hook
  ((js-mode-hook . lsp-javascript-typescript-enable)
   ;; for typescript support
   (typescript-mode-hook . lsp-javascript-typescript-enable)
   ;; for js3-mode support
   (js3-mode-hook . lsp-javascript-typescript-enable)
   ;; for rjsx-mode support
   (rjsx-mode . lsp-javascript-typescript-enable)))
