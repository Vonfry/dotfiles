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

(use-package elysium
  :general
  (vmap-leader
    "' q q" 'elysium-query
    "' q a" 'elysium-add-context)
  (nmap-leader
    "' q q" 'elysium-query
    "' q k" 'elysium-keep-all-suggested-changes
    "' q d" 'elysium-discard-all-suggested-changes
    "' q c" 'elysium-clear-buffer
    "' q a" 'elysium-add-context
    "' q t" 'elysium-toggle-window))
