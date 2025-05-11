;;; aichat/packages.el --- -*- lexical-binding: t; -*-
;;

(use-package gptel
  :general
  (nmap-leader
    "e g g"     'gptel
    "e g C-RET" 'gptel-add-file
    "e g RET"   'gptel-send)
  (vmap-leader
    "e g RET" 'gptel-send
    "e g a"   'gptel-add)
  (nmap-mode :keymaps 'gptel-mode-map
    "RET" 'gptel-send)
  :custom
  (gptel-use-curl t)
  (gptel-backend gptel--openai)
  (gptel-model 'gpt-4o)
  (gptel-org-branching-context t)
  (gptel-default-mode 'org-mode)
  (gptel-api-key
    (lambda ()
      (auth-source-pick-first-password
       :host "api.openai.com"
       :user "gptel"))))

(use-package gptel-aibo
  :after gptel
  :general
  (nmap-leader
    "' q q" 'gptel-aibo)
  (nmap-mode :keymaps 'gptel-aibo-mode-map
    "RET" 'gptel-aibo-send
    "a"   'gptel-aibo-apply-last-suggestions)
  (vmap-leader :keymaps 'prog-mode-map
    "' q s" 'gptel-aibo-summon))

(use-package mcp
  :disabled
  :after gptel
  ; hm manages this with file paths.
  ; For non-nix based system, set this manually.
  ; :custom
  ; (mcp-hub-servers nil)
  :general
  (nmap-leader "' q m" 'mcp-hub))

(use-package gptel-magit
  :after (magit gptel)
  :hook (magit-mode . gptel-magit-install))
