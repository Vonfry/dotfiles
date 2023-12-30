;;; logview/packages.el --- -*- lexical-binding: t -*-
;;

(use-package logview
  :custom
  (logview-cache-filename (expand-file-name "logview.ext" vonfry-cache-dir)))
