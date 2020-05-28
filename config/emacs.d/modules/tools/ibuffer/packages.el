;;; ibuffer packages -*- lexical-binding: t -*-
;;

(package! ibuffer
  :ensure nil
  :init
  (setq ibuffer-formats
        '((mark modified read-only vc-status-mini " "
                (name 18 18 :left :elide)
                " "
                (size-h 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                filename-and-process)
          (mark modified read-only vc-status-mini " "
                (name 18 18 :left :elide)
                " "
                (size-h 9 -1 :right)
                " "
                (mode 16 16 :left :elide)
                " "
                (vc-status 16 16 :left)
                " "
                filename-and-process)))
  (setq ibuffer-filter-group-name-face 'font-lock-doc-face)
  :hook
  (ibuffer .
    (lambda ()
      (setq ibuffer-filter-groups (append
                                    (ibuffer-projectile-generate-filter-groups)
                                    +ibuffer-filter-groups))
      (unless (eq ibuffer-sorting-mode 'alphabetic)
        (ibuffer-do-sort-by-alphabetic))))
  :custom
  (ibuffer-show-empty-filter-groups nil)
  (ibuffer-auto-mode t)
  :config
  (define-ibuffer-column size-h
      (:name "Size" :inline t)
      (cond
       ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
       ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
       (t (format "%8d" (buffer-size)))))
  :general
  ("C-x C-b" 'ibuffer)
  (+mmap-leader-def "B" 'ibuffer))

(package! ibuffer-vc :after ibuffer)

(package! ibuffer-projectile
  :after (ibuffer projectile))
