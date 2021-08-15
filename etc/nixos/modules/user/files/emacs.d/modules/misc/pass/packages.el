;;; packages config -*- lexical-binding: t -*-
;;

(use-package password-store
  :custom
  (password-store-password-length 32)
  :general
  (nmap-at
    "p"   '(:ignore t :which-key "pass")
    "p y" 'password-store-copy
    "p c" 'password-store-clear
    "p s" 'password-store-init
    "p i" 'password-store-insert
    "p e" 'password-store-edit
    "p g" 'password-store-generate
    "p d" 'password-store-remove
    "p r" 'password-store-rename
    "p u" 'password-store-url
    "p v" 'password-store-version))

(use-package auth-source
  :custom
  (auth-sources `(,(expand-file-name "authinfo.gpg" (xdg-data-home))
                  ,(expand-file-name "authinfo" (xdg-data-home))
                  "~/.authinfo.gpg" "~/.authinfo"))
  :ensure nil)


(use-package auth-source-pass
  :after auth-source
  :config
  (auth-source-pass-enable))
