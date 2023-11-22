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

(use-package general
  :custom
  (general-default-prefix nil)
  (general-default-global-prefix nil)
  :config
  (general-evil-setup t t)
  (general-define-key "C-h B" 'general-describe-keybindings)

  ;; Here defines some generic prefix keybinds, and the others are set in each
  ;; modules
  ;; I don't use `:keymaps 'override' because general.el uses
  ;; `evil-make-intercept-map' which cannot work with other keymaps. I want to
  ;; bind some keys only in special modes maps. We also cannot use
  ;; `define-minor-mode' to do this based on same reason. The better soluation
  ;; is using `evil-make-overriding-map' which has higher precedence than global
  ;; one but lower than other maps. and the overriding map is used by
  ;; `evil-collection'.
  (defmacro vonfry--keybind-definer(map)
    (let* ((map-str (symbol-name map))
           (map-leader (intern (concat map-str "-leader")))
           (map-mode   (intern (concat map-str "-mode")))
           (map-at     (intern (concat map-str "-at"))))
      `(progn
         (general-create-definer ,map-leader :wrapping ,map        :prefix "SPC")
         (general-create-definer ,map-mode   :wrapping ,map-leader :infix  "SPC")
         (general-create-definer ,map-at     :wrapping ,map-leader :infix  "@"))))
  (vonfry--keybind-definer nmap)
  (vonfry--keybind-definer vmap)
  (vonfry--keybind-definer nvmap)

  (nmap-leader "Z" 'vonfry/next-theme)
  (nmap-leader "' d" 'vonfry/insert-current-date))

(use-package evil
  :hook
  (window-configuration-change . evil-normalize-keymaps)
  :config
  (evil-mode 1)
  (fset 'evil-visual-update-x-selection 'ignore)
  (advice-add 'vonfry/local-indent
              :after (lambda (int) (setq-local evil-shift-width int)))
  :custom
  (evil-symbol-word-search t)
  (evil-want-keybinding nil)
  (evil-want-integration t)
  (evil-shift-width 4)
  (evil-search-module 'isearch)
  (evil-undo-system 'undo-redo)
  :general
  (nmap :prefix "g"
        "B" 'previous-buffer
        "b" 'next-buffer)
  (nmap-leader
    "f"   'find-file
    "x"   'execute-extended-command
    "M a" 'bookmark-set
    "M A" 'bookmark-set-no-overwrite
    "M l" 'bookmark-bmenu-list
    "M s" 'bookmark-save
    "M d" 'bookmark-delete
    "M r" 'bookmark-rename
    "M w" 'bookmark-write
    "M v" 'evil-show-marks
    "M j" 'evil-show-jumps
    "F B" 'hexl-find-file
    "F b" 'hexl-mode
    "F l" 'find-file-literally
    "!"   'calc
    "\""  'comint-run
    "l"   'list-processes
    "L"   'proced
    "O"   'calendar
    "e a" '+evil/switch-scratch
    "e i" 'ielm
    "e s" 'server-start
    "e c" 'clean-buffer-list
    "e #" 'server-edit
    "e t" 'list-timers
    "e D" 'diff
    "e f" 'evil-show-file-info
    "e m" 'woman)
  (vmap-leader
    "x"   'execute-extended-command
    "="   'align-regexp))

(provide 'vonfry-keybinding)
