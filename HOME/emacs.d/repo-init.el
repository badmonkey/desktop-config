;;; -*- lexical-binding: t; -*-
;;;
;;; init.el --- redirect load real init.el from repo checkout

(message "Redirect to %s" repo-user-init-file)
(load repo-user-init-file)
