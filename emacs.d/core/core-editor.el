;;; core-editor.el -*- lexical-binding: t; -*-
;;
;; Set the configure about editing.

(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))

(defgroup vonfry-editor nil
  "Vonfry's group about editor")

(defcustom vonfry-frame '((width . 160) (height . 72))
  "The default frame width and height"
  :group 'vonfry-editor)

(defcustom vonfry-text-width 120
  "The width for a line"
  :type 'number
  :group 'vonfry-editor)

(defcustom vonfry-backup-file-dir (expand-file-name "backups/" vonfry-local-dir)
  "The backup file dir."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-auto-save-dir (expand-file-name "auto-save/" vonfry-local-dir)
  "The auto-save file dir."
  :type 'directory
  :group 'vonfry-dir)

(defcustom vonfry-auto-save-list-prefix vonfry-auto-save-dir
  "The auto-save file prefix."
  :type 'string
  :group 'vonfry-dir)

(dolist (tmp-dir `(,vonfry-backup-file-dir ,vonfry-auto-save-dir))
  (unless (file-exists-p tmp-dir)
    (make-directory tmp-dir)))

(package! whitespace-cleanup-mode)
(use-package! whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode t))

(package! exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(custom-set-variables
  '(exec-path-from-shell-check-startup-files nil)
  '(initial-frame-alist vonfry-frame)
  '(default-frame-alist vonfry-frame)
  '(blink-cursor-interval 0.4)
  '(buffers-menu-max-size 32)
  '(column-number-mode t)
  '(global-linum-mode t)
  '(global-prettify-symbols-mode t)
  '(show-trailing-whitespace t)
  '(global-whitespace-modes t)
  '(case-fold-search t)

  '(bookmark-default-file (expand-file-name "bookmarks.el" vonfry-local-dir))

  '(mouse-yank-at-point t)
  '(delete-selection-mode t)

  '(indent-tabs-mode nil)
  '(tab-width 4)
  '(c-basic-offset 4)

  '(scroll-bar-mode nil)
  '(scroll-preserve-screen-position 'always)
  '(set-mark-command-repeat-pop t)
  '(tooltip-delay 0.7)

  '(word-wrap t)
  '(truncate-lines nil)
  '(truncate-partial-width-windows vonfry-text-width)
  '(auto-fill-mode t)
  '(fill-column vonfry-text-width)

  '(save-interprogram-paste-before-kill t)

  '(make-backup-files t)
  '(backup-directory-alist `((".*" . ,vonfry-backup-file-dir)))
  '(auto-save-default nil)
  '(auto-save-file-name-transforms `((".*" ,vonfry-auto-save-dir t)))
  '(auto-save-list-file-prefix vonfry-auto-save-list-prefix)

  '(global-visual-line-mode t)
  '(show-paren-mode t)

  '(tramp-default-method "ssh")
  '(tramp-auto-save-directory vonfry-tramp-cache)
  '(tramp-backup-directory-alist `((".*" ,vonfry-tramp-cache)))

  '(browse-url-browser-function 'browse-url-default-browser))

(provide 'core-editor)
