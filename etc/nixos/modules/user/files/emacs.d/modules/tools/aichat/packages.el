;;; aichat packages -*- lexical-binding: t; -*-
;;

(use-package chatgpt-shell
  :general
  (nmap-leader "e g" 'chatgpt-shell)
  :custom
  (chatgpt-shell-model-version "gpt-4")
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
