(in-package #:nyxt-user)

(define-configuration context-buffer
  ((search-engines
    (mapcar
     (lambda (engine) (apply 'make-search-engine engine))
     '(("w"
        "https://en.wikipedia.org/wiki/Special:Search?search=~a&go=Go&ns0=1"
        "https://en.wikipedia.org/")
       ("g"
        "https://www.google.com/search?hl=en&q=~a"
        "https://www.google.com")
       ("nw"
        "https://nixos.wiki/index.php?search=~a"
        "https://nixos.wiki/")
       ("gh"
        "https://github.com/search?type=&q=~a"
        "https://github.com/")
       ("gl"
        "https://gitlab.com/search?search=~a"
        "https://gitlab.com/")
       ("su"
        "https://superuser.com/search?q=~a"
        "https://superuser.com/")
       ("so"
        "https://stackoverflow.com/search?q=~a"
        "https://stackoverflow.com/")
       ("hg"
        "https://hoogle.haskell.org/?scope=set%3Astackage&hoogle=~a"
        "https://hoogle.haskell.org/")
       ("yt"
        "https://www.youtube.com/results?search_query=~a"
        "https://www.youtube.com/")
       ("ie3"
        "https://ieeexplore.ieee.org/search/searchresult.jsp?newsearch=true&queryText=~a"
        "https://ieeexplore.ieee.org/")
       ("se"
        "https://www.sciencedirect.com/search?qs=~a"
        "https://www.sciencedirect.com/")
       ("acm"
        "https://dl.acm.org/action/doSearch?AllField=~a"
        "https://dl.acm.org/")
       ("gs"
        "https://scholar.google.com/scholar?q=~a"
        "https://scholar.google.com/")
       ("doi"
        "https://www.doi.org/~a"
        "https://www.doi.org/")
       ("ddg" ; the last one is the defalut
        "https://duckduckgo.com/?q=~a"
        "https://duckduckgo.com/"))))))
