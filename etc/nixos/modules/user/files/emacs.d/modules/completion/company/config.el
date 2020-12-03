;;; company config -*- lexical-binding: t -*-
;;

(custom! +company-default-backends
 '(company-capf company-yasnippet company-files company-keywords
   company-dabbrev company-dabbrev-code)
 "Default backends. It can be used to combined with special mode."
 :group 'vonfry-modules)

(fun! +company-set-backends (backends)
  "Set backends local, it is appended before the global one."
  (setq-local company-backends (append backends company-backends)))

(fun! +company-backends-grouped (backends)
  "Get backends grouped default one"
  (--map (-uniq (-flatten (cons it +company-default-backends)))
         backends))

(fun! +company-set-backends-grouped (backends)
  "Set backends grouped default one"
  (+company-set-backends (+company-backends-grouped backends)))
