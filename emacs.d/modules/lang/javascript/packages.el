;;; javascript packages -*- lexical-binding: t -*-
;;

(package! js2-mode
  :mode ("\\.js\\'" . js2-mode)
  :hook (js2-mode . js2-imenu-extras-mode)
  :general
  (nmap :keymaps 'js-mode
        :definer 'minor-mode
        :prefix vonfry-keybind-evil-leader
         vonfry-keybind-evil-jump-module 'js-find-symbol))

(package! tern
  :general
  (nmap :keymaps 'tern-mode
        :definer 'minor-mode
        :prefix +lang-nmap-prefix
        ";" 'tern-find-definition
        "." 'tern-find-definition-by-name
        "," 'tern-pop-find-definition
        "t" 'tern-get-type
        "d" 'tern-get-docs)
  :hook (js2-mode . tern-mode))

(package! company-tern
  :after tern company
  :hook
  (js2-mode .
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-tern))))
