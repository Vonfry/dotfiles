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
  :group 'vonfry-editor)

(defconst vonfry-backup-file-dir (expand-file-name "backups/" vonfry-local-dir)
  "The backup file dir."
  :group 'vonfry-dir)

(defconst vonfry-auto-save-dir (expand-file-name "auto-save/" vonfry-local-dir)
  "The auto-save file dir."
  :group 'vonfry-dir)

(defconst vonfry-auto-save-list-prefix vonfry-auto-save-dir
  "The auto-save file prefix."
  :group 'vonfry-dir)

(add-hook 'after-init-hook
  (lambda ()
    (dolist (dir '(vonfry-backup-file-dir vonfry-auto-save-dir)))
      (unless (file-exists-p dir)
        (make-directory dir))))

(custom-set-variables
 '(default-frame-alist vonfry-frame)
 '(blink-cursor-interval 0.4)
 '(buffers-menu-max-size 32)
 '(column-number-mode t)
 '(global-linum-mode t)
 '(global-prettify-symbols-mode t)
 '(show-trailing-whitespace t)
 '(whitespace-style (face trailing))
 '(global-whitespace-modes t)
 '(case-fold-search t)

 '(bookmark-default-file (expand-file-name "bookmarks.el" vonfry-local-dir))

 '(mouse-yank-at-point t)
 '(delete-selection-mode t)

 '(indent-tabs-mode nil)
 '(tab-width 4)

 '(scroll-bar-mode nil)
 '(scroll-preserve-screen-position 'always)
 '(set-mark-command-repeat-pop t)
 '(tooltip-delay 0.7)

 '(word-wrap t)
 '(truncate-lines nil)
 '(truncate-partial-width-windows vonfry-text-width)

 '(save-interprogram-paste-before-kill t)

 '(temporary-file-directory vonfry-local-dir)
 '(make-backup-files t)
 '(backup-directory-alist `((".*" . ,vonfry-backup-file-dir)))
 '(auto-save-file-name-transforms `((".*" ,vonfry-auto-save-dir t)))
 '(auto-save-list-file-prefix vonfry-auto-save-list-prefix)

 '(global-visual-line-mode t)
 '(show-paren-mode t))

(add-hook 'write-file-hook 'whitespace-cleanup)

(provide 'core-editor)
