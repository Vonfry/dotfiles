;;; config func -*- lexical-binding: t -*-
;;

(custom! +jekyll-root nil
  "A root for jekyll project"
  :group 'vonfry-modules
  'type 'directory)

(custom! +jekyll-static-dir (expand-file-name "static" +jekyll-root)
  "A dir saves static files"
  :group 'vonfry-modules
  'type 'directory)

(custom! +jekyll-url "https://vonfry.name"
  "the url where jekyll is run."
  :group 'vonfry-modules
  :type 'string
  :custom-set 'easy-jekyll-url)

(custom! +jekyll-images-dir (expand-file-name "images" +jekyll-static-dir)
  "A dir saves pictures"
  :group 'vonfry-modules
  :type 'directory
  :custom-set 'easy-jekyll-image-directory)
