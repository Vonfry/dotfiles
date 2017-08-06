;;; bm config -*- lexical-binding: t -*-

(vonfry|use-package! bm
  :init
  (defcustom +bm-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-marks)
    "bm keybind map"
    :group 'vonfry-module)
  :general
  (nmap :prefix +bm-nmap-prefix)
    "t" 'bm-toggle
    "m" 'helm-bookmarks)
