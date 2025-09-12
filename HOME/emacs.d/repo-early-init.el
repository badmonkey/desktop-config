;;; -*- lexical-binding: t; -*-
;;;
;;; early-init.el --- Load real early-init.el from repo checkout

(setq repo-emacs-directory "~/projects/desktop-config/HOME/emacs.d/"
  repo-user-earlyinit-file (expand-file-name "early-init" repo-emacs-directory)
  repo-user-init-file (expand-file-name "init" repo-emacs-directory))

(message "Redirect to %s" repo-user-earlyinit-file)
(load repo-user-earlyinit-file)
