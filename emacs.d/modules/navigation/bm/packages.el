;;; bm packages -*- lexical-binding: t -*-

(package! bm
  :init
  (defcustom +bm-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-book-marks)
    "bm keybind map"
    :type 'string
    :group 'vonfry-modules)
  :general
  (nmap :prefix +bm-nmap-prefix
    "t" 'bm-toggle
    "m" 'counsel-bookmark))
