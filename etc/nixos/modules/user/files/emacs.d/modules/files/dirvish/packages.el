;;; dirvish/packages.el --- -*- lexical-binding: t -*-

(use-package dirvish
  :custom
  (dirvish-cache-dir (expand-file-name "dirvish" vonfry-cache-dir))
  (dired-dwim-target t)
  (dired-guess-shell-alist-user
   (list
    (list
     (rx ".pdf" eos)
     "zathura")
    (list
     (rx "." (| "png" (: "jp" (? "e") "g") "gif") eos)
     "feh -.")
    (list
     (rx "." (| "mp3" "mp4" "wav" "flac" "mkv" "mov") eos)
     "mpv")
    (list
     (rx "." (| "zip" "7z") eos)
     "arc ls")))
  :config
  (dirvish-override-dired-mode 1)
  :general
  ; avoid overwrite from evil-collections of dired
  (nmap-mode :keymaps 'dired-mode-map nil 'dirvish-dispatch)
  (nmap-leader
    "d"   'dirvish-dwim
    "D d" 'dirvish
    "D D" 'dired-jump
    "D h" 'dirvish-history-jump
    "D H" 'dirvish-history
    "D o" 'dired-jump-other-window))

(use-package dirvish-side
  :ensure nil
  :after dirvish
  :general
  (nmap-leader
    "D t" 'dirvish-side))

(use-package dirvish-vc :ensure nil :after (magit dirvish))

(use-package dirvish-extras :ensure nil :after dirvish)

(use-package dirvish-evil-collection-deal
  :no-require
  :after (dirvish evil-collection)
  :general
  (nmap :keymaps 'dired-mode-map
    "q" 'dirvish-quit))
