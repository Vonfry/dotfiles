;;; bm config -*- lexical-binding: t -*-

(use-package! bm
  :init
  (defcustom +bm-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-book-marks)
    "bm keybind map"
    :type 'string
    :group 'vonfry-modules)
  :general
  (nmap :prefix +bm-nmap-prefix
    "t" 'bm-toggle
    "m" 'helm-bookmarks))
