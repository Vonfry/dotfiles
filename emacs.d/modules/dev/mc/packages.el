;;; mc packages -*- lexical-binding: t -*-
;;

(package! evil-multiedit
  :after evil
  :general
  (vmap "R" 'evil-multiedit-match-all
        "M-D" 'evil-multiedit-and-prev
        "M-d" 'evil-multiedit-and-next
        "C-M-D" 'evil-multiedit-restore)
  (nmap (kbd "M-d") 'evil-multiedit-match-and-next
        "M-D" 'evil-multiedit-match-and-prev)
  (imap "M-d" 'evil-multiedit-toggle-marker-here)
  (mmap "RET" 'evil-multiedit-toggle-or-restrict-region)
  (:keymaps evil-multiedit-state-map
            (kbd "RET") 'evil-multiedit-toggle-or-restrict-region
            (kbd "C-n") 'evil-multiedit-next
            (kbd "C-p") 'evil-multiedit-prev)
  (:keymaps evil-multiedit-insert-state-map
            (kbd "C-n") 'evil-multiedit-next
            (kbd "C-p") 'evil-multiedit-prev)
  :config
  (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match))
