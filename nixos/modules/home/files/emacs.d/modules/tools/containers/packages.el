;;; container/packages.el --- -*- lexical-binding: t -*-
;;

(use-package docker
  :custom
  (docker-command "podman")
  (docker-compose-command "podman compose")
  (docker-container-tramp-method "podman")
  :general
  (nmap-leader
    "s d" 'docker))
