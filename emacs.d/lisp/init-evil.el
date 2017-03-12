(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-surround)
(require-package 'evil-visualstar)
(require-package 'evil-numbers)
(require-package 'evil-magit)
(require-package 'evil-snipe)
(require-package 'evil-matchit)
(require-package 'evil-nerd-commenter)

(setq evil-emacs-state-cursor  '("red" box))
(setq evil-normal-state-cursor '("gray" box))
(setq evil-visual-state-cursor '("gray" box))
(setq evil-insert-state-cursor '("gray" bar))
(setq evil-motion-state-cursor '("gray" box))

(global-evil-leader-mode)
(setq *evil-leader-key* "<SPC>")
(evil-leader/set-leader *evil-leader-key*)
(evil-leader/set-key
  ":"  'shell-command
  "b"  'ibuffer
  "m"  'evil-show-marks
  "u"  'undo-tree-visualize
  "'"  'ielm
;; setting for evil-nerd-commenter
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "c."  'evilnc-copy-and-comment-operator
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
)

(evil-mode 1)
(evil-snipe-mode 1)
(global-evil-surround-mode 1)
(global-evil-matchit-mode 1)
(define-key evil-normal-state-map (kbd "C-A")
  'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-S-A")
  'evil-numbers/dec-at-pt)
(require 'evil-magit)

(setq-default evil-shift-width 4)

(evil-leader/set-key-for-mode 'org-mode
    "c" 'org-cycle
    "e" 'org-export-dispatch
    "n" 'outline-next-visible-heading
    "p" 'outline-previous-visible-heading
    "t" 'org-set-tags-command
    "u" 'outline-up-heading)
(evil-declare-key 'normal org-mode-map
    "gk" 'outline-up-heading
    "gj" 'outline-next-visible-heading
    (kbd "TAB") 'org-cycle
    "H" 'org-beginning-of-line ; smarter behaviour on headlines etc.
    "L" 'org-end-of-line ; smarter behaviour on headlines etc.
    "t" 'org-todo ; mark a TODO item as DONE
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "-" 'org-ctrl-c-minus ; change bullet style
    "<" 'org-metaleft ; out-dent
    ">" 'org-metaright ; indent
    )

(provide 'init-evil)
