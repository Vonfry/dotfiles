;; package engine -*- lexical-binding: t -*-
;;

(package! engine-mode
  :config
  (engine-mode t)
  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s"
		:keybinding "u")
  (defengine gist
    "https://gist.github.com/search?utf8=%E2%9C%93&q=%s"
		:keybinding "i")
  (defengine gitlab
    "https://gitlab.com/search?utf8=%E2%9C%93&search=%s"
		:keybinding "a")
  (defengine google
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
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
    :keybinding "h"))
