;;; -*- lexical-binding: t; -*-
;;; init.el --- Configure all the things
;;; Commentary:
;;; Code:


;; Fiddle with Garbage Collection

;; (defvar gc-cons-threshold-large)
;; (defvar gc-cons-threshold-original)

;; (setq gc-cons-threshold-large (* 1024 1024 100))
;; (setq gc-cons-threshold-original gc-cons-threshold)
;; (setq gc-cons-threshold gc-cons-threshold)

;; (run-with-idle-timer 5 nil
;;   (lambda ()
;;     (setq gc-cons-threshold gc-cons-threshold-original)
;;     (message "gc-cons-threshold restored")))

;; (defun my-minibuffer-setup-hook ()
;;   (setq gc-cons-threshold gc-cons-threshold-large))

;; (defun my-minibuffer-exit-hook ()
;;   (setq gc-cons-threshold gc-cons-threshold-original))

;; (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
;; (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)


;; Add custom code to the load path.
;; `contrib' is code snippets from the internet
;; `lisp' is for my code
(defvar contrib-load-path)

(setq contrib-load-path (expand-file-name "contrib" user-emacs-directory))
(add-to-list 'load-path contrib-load-path)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


;; bootstrap straight
(message "Starting straight...")
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq straight-cache-autoloads t)


(use-package esup)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#000000" "#8b0000" "#00ff00" "#ffa500" "#7b68ee" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("eb25c68d3959c31d34021aa722d5ea1c53ea69714580b2b8c150592becf412cf" "b15fa7a81be21941faa7923d39f2b0627120cea6487d21b1c5638435b297bd87" "2aa073a18b2ba860d24d2cd857bcce34d7107b6967099be646d9c95f53ef3643" "5cce533073e34bfd8ea173887b2566b2b5165309231bdd6088ea92ee76ce114b" "6e70d505e0957aaa67562ff0487b7b1b1e10f879655f2c47adf85949790fb687" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(fci-rule-color "#383838")
 '(frame-brackground-mode 'dark)
 '(fringe-mode 6 nil (fringe))
 '(linum-format 'dynamic)
 '(make-pointer-invisible nil)
 '(mouse-yank-at-point t)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(zig-mode avy dashboard-project-status dashboard-hackernews helm-unicode flycheck-swiftlint f rust-mode swift-mode go-mode helm-gtags ggtags imenu-anywhere multi-term gitlab-ci-mode helm-ispell change-inner clipmon goto-last-change major-mode-hydra helm-google helm-posframe markdown-toc fill-column-indicator flycheck-posframe markdown-preview-eww vmd-mode helm-rg projectile-ripgrep fringe-helper posframe jedi flycheck-inline color-identifiers-mode color-identifiers smart-region pretty-hydra highlight-indent-guides indent-guide side-notes with-venv auto-virtualenvwrapper switch-buffer-functions mc-extras multiple-cursors spaceline-all-the-icons all-the-icons hl-todo flycheck-pyre flycheck crux virtualenvwrapper blacken counsel-etags counsel swiper ivy rainbow-delimiters magit erlang pandoc-mode json-mode diminish use-package projectile flx-ido))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(py-pyment-options '("--output" "reST"))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:background "#51afef" :foreground "#870000" :weight bold))))
 '(flycheck-posframe-border-face ((t (:foreground "DarkRed"))))
 '(hl-line ((t (:background "gray5"))))
 '(markdown-header-delimiter-face ((t (:foreground "mediumpurple"))))
 '(markdown-header-face-1 ((t (:foreground "violet" :weight bold :height 1.0))))
 '(markdown-header-face-2 ((t (:foreground "lightslateblue" :weight bold :height 1.0))))
 '(markdown-header-face-3 ((t (:foreground "mediumpurple1" :weight bold :height 1.0))))
 '(markdown-link-face ((t (:background "#0e1014" :foreground "#bd93f9"))))
 '(markdown-list-face ((t (:foreground "mediumpurple"))))
 '(markdown-pre-face ((t (:foreground "#bd98fe"))))
 '(whitespace-empty ((t (:foreground "red" :background "red"))))
 '(whitespace-indentation ((t (:foreground "yellow" :background "black"))))
 '(whitespace-line ((t (:foreground unspecified :underline "DarkRed"))))
 '(whitespace-newline ((t (:foreground "blue" :background "black"))))
 '(whitespace-space ((t (:foreground "gray25" :background "black"))))
 '(whitespace-space-after-tab ((t (:foreground "yellow" :background "black"))))
 '(whitespace-space-before-tab ((t (:foreground "red" :background "black"))))
 '(whitespace-tab ((t (:foreground "blue" :background "black"))))
 '(whitespace-trailing ((t (:bold t :foreground "red" :background "black")))))
