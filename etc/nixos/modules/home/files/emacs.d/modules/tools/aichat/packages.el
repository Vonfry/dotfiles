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
  (gptel-org-branching-context t)
  (gptel-default-mode 'org-mode)
  (gptel-model 'gpt-4.5-preview)
  (gptel-api-key
    (lambda ()
      (auth-source-pick-first-password
       :host "api.anthropic.com"
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
  ; hm manages this with file paths.
  ; For non-nix based system, set this manually.
  ; :custom
  ; (mcp-hub-servers nil)
  :config
  (evil-set-initial-state 'mcp-hub-mode 'emacs)
  :general
  (nmap-leader
    "' q m" 'mcp-hub
    "' q M" '+mcp/init-servers))

(use-package gptel-magit
  :after (magit gptel)
  :hook (magit-mode . gptel-magit-install))

(use-package gptel-integrations
  :after mcp
  :ensure gptel
  :general
  (nmap-leader
    "' q c" 'gptel-mcp-connect
    "' q d" 'gptel-mcp-disconnect))
