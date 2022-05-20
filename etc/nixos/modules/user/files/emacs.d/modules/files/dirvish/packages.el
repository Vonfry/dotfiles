;;; dirvish packages -*- lexical-binding: t -*-

(use-package dirvish
  :custom
  (dirvish-cache-dir (expand-file-name "dirvish" vonfry-cache-dir))
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
