;;; browse packages -*- lexical-binding: t -*-
;;

(package! speedbar :ensure nil)

(package! sr-speedbar
  :after speedbar
  :custom (sr-speedbar-auto-refresh nil))

(package! projectile-speedbar
  :after sr-speedbar
  :custom (projectile-speedbar-enable nil)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-speedbar 'sr-speedbar-toggle))
