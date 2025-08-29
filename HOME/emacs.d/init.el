;;; -*- lexical-binding: t; -*-
;;; init.el --- Configure all the things
;;; Commentary:
;;; Code:


(setq user-init-file (or load-file-name (buffer-file-name)))
;;(setq user-emacs-directory (file-name-directory user-init-file))


;; Add custom code to the load path.
;; `contrib' is code snippets from the internet
;; `lisp' is for my code
(defvar contrib-load-path)

(setq contrib-load-path (expand-file-name "contrib" user-emacs-directory))
(add-to-list 'load-path contrib-load-path)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq custom-file  (expand-file-name "custom.el" user-emacs-directory))

;; bootstrap straight
(message "Starting straight...")
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq straight-cache-autoloads t)


(use-package esup)

;; Fiddle with Garbage Collection

(add-function :after
  after-focus-change-function
  (lambda () (unless (frame-focus-state) (garbage-collect))))

(use-package gcmh
  :config
  (setq garbage-collection-messages t)
  (gcmh-mode t))


;; Load somne library packages
(message "Loading libraries...")
(use-package dash)
(use-package s)
(use-package s-buffer)
(use-package f)

;; start loading packages
(message "Loading packages...")
(require 'init-settings)
(require 'init-package)
(require 'init-visuals)

(require 'init-general-defuns)

(message "Loading editor packages...")
(require 'init-editor)
(require 'init-snippets)
(require 'init-project)
(require 'init-flycheck)
(require 'init-helm)

(require 'init-modes)
(require 'init-text)
(require 'init-lang)
(require 'init-python)

;; init that requires most packages are loaded
(require 'init-interactive-defuns)
(require 'init-powerline)

(message "Loading key bindings...")
(general-auto-unbind-keys)
(require 'init-hydra)
(require 'init-ctrlchords)
(require 'init-metachords)
(require 'init-keychords)
(general-auto-unbind-keys t)

(message "Starting server...")
(require 'init-server)

(load-file custom-file)
