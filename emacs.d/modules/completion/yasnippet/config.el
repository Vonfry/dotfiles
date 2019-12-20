;;; yasnippet config -*- lexical-binding: t -*-
;;

(defconst +yas-snippet-dirs
  (list (expand-file-name "snippets/" vonfry-local-dir)
        (expand-file-name "snippets/" vonfry-custom-dir)
        (expand-file-name "../snippets" load-file-name))
  "Vonfry's snippets dir")

