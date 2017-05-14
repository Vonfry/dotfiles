(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))

;;----------------------------------------------------------------------------
;; Some basic preferences
;;----------------------------------------------------------------------------
(setq-default
 default-frame-alist '((width . 160) (height . 72))
 blink-cursor-interval 0.4
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil
 tab-width 4
 make-backup-files nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 scroll-bar-mode nil
 word-wrap t
 truncate-lines nil
 truncate-partial-width-windows nil)
(setq vonfry/temporary-file-directory (expand-file-name "~/.cache/emacs/"))
(setq
  backup-directory-alist `((".*" . ,vonfry/temporary-file-directory))
  auto-save-file-name-transforms `((".*" ,vonfry/temporary-file-directory t))
  auto-save-list-file-prefix vonfry/temporary-file-directory)
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
  auto-revert-verbose nil)
(global-visual-line-mode t)
(transient-mark-mode t)

;;----------------------------------------------------------------------------
;; Show matching parens
;;----------------------------------------------------------------------------
(show-paren-mode 1)

(require-package 'diminish)
(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

(when (require-package 'indent-guide)
  (add-hook 'prog-mode-hook 'indent-guide-mode)
  (with-eval-after-load 'indent-guide
    (diminish 'indent-guide-mode)))
(require-package 'nlinum)
(global-nlinum-mode)

(when (require-package 'rainbow-mode)
  (add-hook 'prog-mode-hook 'rainbow-mode))
(when (require-package 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))

(require-package 'which-key)
(setq which-key-idle-delay 0.8
      which-key-allow-evil-operators t)
(add-hook 'after-init-hook
  (lambda ()
    (which-key-mode)))

(require-package 'fic-mode)
(require 'fic-mode)
(custom-set-variables '(fic-highlighted-words (quote ("FIXME" "TODO" "BUG" "KLUDGE" "IMPORTANT"))))
(add-hook 'prog-mode-hook 'fic-mode)
(add-hook 'org-mode-hook 'fic-mode) ;; to disable

;;; Fill column indicator
(require-package 'fill-column-indicator)
(setq-default fci-rule-column 120)
(defun prog-mode-fci-settings ()
  (turn-on-fci-mode)
  (when show-trailing-whitespace
    (set (make-local-variable 'whitespace-style) '(face trailing))
    (whitespace-mode 1)))

(add-hook 'prog-mode-hook 'prog-mode-fci-settings)

(defun fci-enabled-p ()
  (bound-and-true-p fci-mode))

(defvar fci-mode-suppressed nil)
(make-variable-buffer-local 'fci-mode-suppressed)

(defadvice popup-create (before suppress-fci-mode activate)
  "Suspend fci-mode while popups are visible"
  (let ((fci-enabled (fci-enabled-p)))
    (when fci-enabled
      (setq fci-mode-suppressed fci-enabled)
      (turn-off-fci-mode))))
(defadvice popup-delete (after restore-fci-mode activate)
  "Restore fci-mode when all popups have closed"
  (when (and fci-mode-suppressed
             (null popup-instances))
    (setq fci-mode-suppressed nil)
    (turn-on-fci-mode)))
(defun on-off-fci-before-company(command)
  (when (string= "show" command)
    (turn-off-fci-mode))
  (when (string= "hide" command)
    (turn-on-fci-mode)))
(advice-add 'company-call-frontends :before #'on-off-fci-before-company)
;; Regenerate fci-mode line images after switching themes
(defadvice enable-theme (after recompute-fci-face activate)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (fci-enabled-p)
        (turn-on-fci-mode)))))

(defun vonfry/toggle-current-window-dedication ()
  "Toggle whether the current window is dedicated to its current buffer."
  (interactive)
  (let* ((window (selected-window))
         (was-dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not was-dedicated))
    (message "Window %sdedicated to %s"
             (if was-dedicated "no longer " "")
             (buffer-name))))
(global-set-key (kbd "C-c <down>") 'vonfry/toggle-current-window-dedication)

; (require-package 'pretty-mode)
; (global-pretty-mode t)

(provide 'init-edit)
