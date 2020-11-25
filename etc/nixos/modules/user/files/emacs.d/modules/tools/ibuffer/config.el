;;; ibuffer config -*- lexical-binding: t -*-
;;

(custom! +ibuffer-filter-groups
  '(("IRC"       (mode . erc-mode))
    ("Mu4e"      (name . "\\*mu4e-.*\\*"))
    ("Gnus"      (or (mode . group-mode)
                     (mode . summary-mode)
                     (mode . article-mode)
                     (mode . compse-mode)))
    ("Flycheck"  (name . "\\*Flycheck.*\\*"))
    ("Elfeed"    (name . "\\*elfeed.*\\*"))
    ("Process"   (or (mode . process-menu-mode)
                     (mode . proced-mode)))
    ("Lisp"      (or (mode . lisp-interaction-mode)
                     (mode . ielm-mode)))
    ("Shell"     (or (mode . shell-mode)
                     (mode . eshell-mode)))
    ("Comint"    (derived-mode . comint-mode))
    ("LSP"       (name . "\\*lsp-.*\\*"))
    ("MPD"       (or (name . "\\*mpd\\*")
                     (mode . mpdel-playlist-mode)
                     (mode . mpdel-tablist-mode)
                     (mode . mpdel-song-mode)
                     (mode . mpdel-playlist-stored-playlist-mode)
                     (mode . mpdel-browser-mode)
                     (mode . mpdel-playlist-current-playlist-mode)))
    ("Message"   (or (name . "\\*.**\\*")
                     (mode . help-mode)))
    ("Org Tool" (name . "\\*org-roam\\*")))
  "ibuffer groups, because of `ibuffer-projectile', config it here. See more `ibuffer-filter-groups'"
  :type 'sexp
  :group 'vonfry-modules)
