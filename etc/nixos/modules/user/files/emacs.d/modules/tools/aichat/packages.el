;;; aichat/packages.el --- -*- lexical-binding: t; -*-
;;

(use-package shell-maker
  :custom
  (shell-maker-history-path (expand-file-name "shell-maker" vonfry-local-dir)))

(use-package chatgpt-shell
  :general
  (nmap-leader "e g" 'chatgpt-shell)
  :custom
  (chatgpt-shell-model-version "gpt-4-1106-preview")
  (chatgpt-shell-openai-key
    (lambda ()
      (auth-source-pick-first-password
       :host "api.openai.com"
       :user "chatgpt-shell"))))

(use-package dall-e-shell
  :custom
  ((dall-e-shell-openai-key
    (lambda ()
      (auth-source-pick-first-password
       :host "api.openai.com"
       :user "chatgpt-shell"))))
  :general
  (nmap-leader "e G" 'dall-e-shell))
