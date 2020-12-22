;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal. I don't use `general-default-prefix` to
;; set leader because there are some normal bind without leader.
;;
;; All local map set for major or minor mode map by default. Only if the minor mode hasn't a map, such as robe, using
;; evil minor mode map instead which use a hook to add into local map.
;; All keybind use general.el to manage.
;;
;; All keys combine with leader when setting, this can have a more structed definitation.

(package! general
  :custom
  (general-default-prefix nil)
  (general-default-global-prefix nil)
  :config
  (general-evil-setup t t)
  (general-define-key "C-h B" 'general-describe-keybindings)
  (general-create-definer nmap-leader :wrapping nmap :prefix "SPC")
  (general-create-definer vmap-leader :wrapping vmap :prefix "SPC")

  ;; Here defines some generic prefix keybinds, and the others are set in each
  ;; modules
  (general-create-definer nmap-mode :wrapping nmap-leader :infix "SPC")
  (general-create-definer vmap-mode :wrapping vmap-leader :infix "SPC")
  (general-create-definer nmap-at :wrapping nmap-leader :infix "@")
  (general-create-definer vmap-at :wrapping vmap-leader :infix "@")

  (nmap-mode "" '(nil :which-key "mode special"))
  (vmap-mode "" '(nil :which-key "mode special"))
  (nmap-at "" '(nil :which-key "web/mail/contacts/.."))
  (vmap-at "" '(nil :which-key "web/mail/contacts/.."))

  (nmap-leader "Z" 'vonfry/next-theme)
  (nmap-leader "' d" 'vonfry/insert-current-date))

(provide 'vonfry-keybinding)
