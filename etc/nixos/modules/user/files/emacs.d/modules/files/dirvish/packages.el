;;; dirvish packages -*- lexical-binding: t -*-

(use-package dirvish
  :custom
  (dirvish-cache-dir (expand-file-name "dirvish" vonfry-cache-dir))
  (dired-guess-shell-alist-user
   (list
    (list
     (rx ".pdf" bos)
     "zathura")
    (list
     (rx "." (| "png" (: "jp" (? "e") "g") "gif") bos)
     "feh -.")
    (list
     (rx "." (| "mp3" "mp4" "wav" "flac" "mkv" "mov") bos)
     "mpv")
    (list
     (rx "." (| "zip" "7z") bos)
     "arc ls")))
  :config
  (dirvish-override-dired-mode 1)
  :general
  (nmap-leader
    "d"   'dirvish-dwim
    "D d" 'dirvish
    "D D" 'dirvish-dired))

(use-package dirvish-side :after dirvish
  :general
  (nmap-leader
    "D t" 'dirvish-side))

(use-package dirvish-vc :after (magit dirvish))

(use-package dirvish-extras :after dirvish)
