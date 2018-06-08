;;; ivy packages -*- lexical-binding: t -*-
;;

(package! ivy)
(package! swiper)
(package! counsel
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  (nmap :prefix +nmap-leader
        +nmap-M-x   'counsel-M-x
        +nmap-file  'counsel-find-file
        +nmap-swiper 'swiper
        +nmap-marks 'counsel-mark-ring
        +nmap-buffer-switch 'ivy-switch-buffer))
(package! ivy-rich
  :after counsel
  :config
  (advice-add 'ivy-rich-switch-buffer-pad :override
              (lambda (str len &optional left)
                "Improved version of `ivy-rich-switch-buffer-pad' that truncates long inputs."
                (let ((real-len (length str)))
                  (cond
                    ((< real-len len) (if left
                                        (concat (make-string (- len real-len) ? ) str)
                                        (concat str (make-string (- len real-len) ? ))))
                    ((= len real-len) str)
                    (t (concat (substring str 0 (- len 1)) "…"))))))
  (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer))
