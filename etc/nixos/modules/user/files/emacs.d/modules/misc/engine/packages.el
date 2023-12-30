;; package/engine.el --- -*- lexical-binding: t -*-
;;

(use-package engine-mode
  :config
  (engine-mode 1)
  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s"
		:keybinding "u")
  (defengine gist
    "https://gist.github.com/search?q=%s"
		:keybinding "i")
  (defengine gitlab
    "https://gitlab.com/search?search=%s"
		:keybinding "a")
  (defengine google
    "http://www.google.com/search?q=%s"
    :keybinding "g")
  (defengine stack-overflow
    "https://stackoverflow.com/search?q=%s"
		:keybinding "s")
  (defengine twitter
    "https://twitter.com/search?q=%s"
		:keybinding "t")
  (defengine wikipedia
    "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
    :keybinding "w")
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d")
  (defengine wiktionary
    "https://www.wikipedia.org/search-redirect.php?family=wiktionary&language=en&go=Go&search=%s"
    :keybinding "W")
	(defengine rfcs
		 "http://pretty-rfc.herokuapp.com/search?q=%s"
		 :keybinding "r")
  (defengine wiktionary
		"http://hackage.haskell.org/packages/search?terms=%s"
		:keybinding "H")
  (defengine hoogle
    "https://www.haskell.org/hoogle/?hoogle=%s"
    :keybinding "h")
  :general
  (nmap-at "/" engine-mode-prefixed-map))
