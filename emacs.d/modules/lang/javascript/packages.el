;;; javascript packages -*- lexical-binding: t -*-

(package! js2-mode
  :mode ("\\.js\\'" . js2-mode)
  :hook
  ((js2-mode . js2-imenu-extras-mode)
  (js2-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
             vonfry-keybind-evil-jump-module 'js-find-symbol)))))

(package! tern
  :hook
  ((js2-mode . tern-mode)
  (js2-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            ";" 'tern-find-definition
            "." 'tern-find-definition-by-name
            "," 'tern-pop-find-definition
            "t" 'tern-get-type
            "d" 'tern-get-docs)))))

(package! company-tern
  :after tern company
  :hook
  (js2-mode .
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-tern))))
