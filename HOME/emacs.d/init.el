;;; -*- lexical-binding: t; -*-
;;; init.el --- Configure all the things
;;; Commentary:
;;; Code:

;;
;;;;;;;; Setup variables needed for loading packages ;;;;;;;;
;;
(setq user-init-file (or load-file-name (buffer-file-name)))
;;(setq user-emacs-directory (file-name-directory user-init-file))


(defvar user-sitelisp-directory (expand-file-name "site-lisp" user-emacs-directory)
  "Directory with user's site-lisp files saved from the internat")

(add-to-list 'load-path user-sitelisp-directory)
(add-to-list 'load-path (expand-file-name "startup" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Set eln-cache dir
;;(when (boundp 'native-comp-eln-load-path)
;;  (startup-redirect-eln-cache (expand-file-name "eln-cache" user-emacs-directory)))

(setq native-comp-jit-compilation t
  native-comp-async-report-warnings-errors nil
  native-comp-speed 3)


;;
;;;;;;;; Setup startup features ;;;;;;;;
;;

;; slow-visuals profile
(defvar user-startup-allow-features `("slow-visuals")
  "List of user features to process during startup")

(defmacro startup-disable (targets)
  `(setq user-startup-allow-features
     (-remove (lambda (x) (-contains? ,targets x)) user-startup-allow-features)))

(defun startup-when (name) (-contains? user-startup-allow-features name))

(message "Config for platform \"%s\"" system-type)
(when (display-graphic-p)
  (push "graphics" user-startup-allow-features))

(cl-case system-type
  (`darwin
    (ignore))
  ((`ms-dos `windows-nt `cygwin)
    (startup-disable `("slow-visuals")))
  (`gnu/linux
    (ignore)))

(message "Startup features %s..." user-startup-allow-features)

;;
;;;;;;;; bootstrap straight ;;;;;;;;
;;
(message "Starting straight...")
(custom-set-variables
  '(straight-repository-branch "develop")
  '(straight-check-for-modifications '(check-on-save find-when-checking))
  '(straight-use-package-by-default t)
  '(straight-vc-git-default-clone-depth 1))

(defvar bootstrap-version)
(let ((bootstrap-file
        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
       (bootstrap-version 7))
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


;;
;;;;;;;; Fiddle with the garbage collector ;;;;;;;;
;;

(add-function :after
  after-focus-change-function
  (lambda () (unless (frame-focus-state) (garbage-collect))))

(use-package gcmh
  :config
  (setq garbage-collection-messages t)
  (gcmh-mode t))


;;
;;;;;;;; Start normal package loading ;;;;;;;;
;;

;; profiler
(use-package esup
  :if (startup-when "profile")
  )

;; Load somne library packages
(message "Loading library packages...")
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

;; init that requires most other init files are already loaded
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
