;;; elixir packages -*- lexical-binding: t -*-
;;

(package! elixir-mode
  :general
  (+mmap-mode-elixir-def
   "?" 'elixir-mode-open-elixir-home
   "=" 'elixir-format))

(package! elixir-yasnippets :after yasnippet-snippets)
