;;; orderless/packages.el --- -*- lexical-binding: t -*-
;;

(use-package orderless
  :custom
  (completion-styles '(orderless basic partial-completion))
  (completion-category-overrides '((file (styles basic partial-completion)))))
