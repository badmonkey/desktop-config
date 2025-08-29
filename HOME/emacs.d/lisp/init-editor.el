;;; ...  -*- lexical-binding: t -*-
;;;
;;; init-editor --- Configure editor features

;; https://github.com/jpkotta/syntax-subword/tree/9aa9b3f846bfe2474370642458a693ac4760d9fe
;; https://github.com/akicho8/string-inflection/tree/c4a519be102cb99dd86be3ee8c387f008d097635
;; https://github.com/knu/replace-with-inflections.el/tree/d9201e047856492f282da65459b28aba25998dbb
;; https://github.com/codemac/config/blob/master/emacs.d/boot.org


(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))
(with-current-buffer "*Messages*"
  (emacs-lock-mode 'kill))


(setq desktop-load-locked-desktop t)
(desktop-save-mode 1)


(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)


;; https://github.com/raxod502/selectrum
;; https://github.com/raxod502/prescient.el
;; https://github.com/oantolin/embark/
;; https://github.com/minad/consult
;; https://github.com/minad/marginalia
;; https://github.com/minad/corfu

;; (use-package marginalia
;;   :defer t
;;   :init
;;   (marginalia-mode)
;;   (setq marginalia-annotators '(marginalia-annotators-heavy nil)))

;; (use-package cape
;;   :init
;;   (dolist (fn (list #'cape-file
;;                 (cape-capf-super #'cape-dabbrev #'cape-dict #'org-block-capf #'cape-keyword)))
;;     (add-to-list 'completion-at-point-functions fn))
;;   :config
;;   (let ((wordlist (getenv "WORDLIST")))
;;     (setq
;;       cape-dict-file wordlist
;;       ispell-alternate-dictionary wordlist)))


;; (use-package keyfreq
;;   :init
;;   (setq keyfreq-excluded-commands
;;         '(self-insert-command
;;           abort-recursive-edit
;;           forward-char
;;           backward-char
;;           left-char
;;           right-char
;;           previous-line
;;           next-line
;;           helm-next-line
;;           helm-previous-line
;;           helm-M-x
;;           newline
;;           proj-open-file
;;           save-buffer
;;           yank))
;;   :config
;;   (setq keyfreq-file (f-join user-emacs-directory "keyfreq.dat"))
;;   (setq keyfreq-file-lock (f-join user-emacs-directory "keyfreq.lock"))
;;   (keyfreq-mode nil)
;;   (keyfreq-autosave-mode 1))


(use-package general)

(use-package key-chord
  :init
  (key-chord-mode 1))


;;; Hail Hydra!

(use-package posframe)

(use-package hydra
  :config
  (use-package hydra-posframe
    :straight (:host github :repo "Ladicle/hydra-posframe"
               :fork (:host github :repo "jerrypnz/hydra-posframe"))
    :custom
    (hydra-posframe-parameters
      '((left-fringe . 5)
        (right-fringe . 5)))
    ;; :custom-face
    ;; (hydra-posframe-border-face ((t (:background "#6272a4"))))
    :hook (after-init . hydra-posframe-enable)))

(use-package major-mode-hydra
  :after hydra)


;;; multi/smart selection

(use-package region-state
  :init
  (region-state-mode 1))

(use-package multiple-cursors)

(use-package expand-region
  :config
  (setq-default er/try-expand-list
                (append er/try-expand-list
                        '(er/mark-line
                          er/mark-sentence
                          er/mark-paragraph))))

(use-package smart-region)

(use-package change-inner)

;; (use-package fancy-narrow)

;; (use-package puni)


(use-package avy
  :config
  (avy-setup-default)
  (setq avy-background t)
  :custom
  (avy-timeout-seconds 0.5)
  (avy-style 'words)
  :custom-face
  (avy-lead-face ((t (:background "#51afef" :foreground "#870000" :weight bold)))))


(use-package crux)

(use-package revbufs)

;; realgud
;; realgud-ipdb

;; (use-package electric
;;   :hook (prog-mode . electric-indent-mode))

(use-package multi-term
  :load-path user-sitelisp-directory
  :config
  (setq multi-term-program "/bin/bash")
  (setq multi-term-dedicated-window-height 40)
  (setq multi-term-dedicated-select-after-open-p t)
  (setq multi-term-dedicated-close-back-to-open-buffer-p t))

(use-package zeal-at-point)

(use-package google-this)

(use-package legalese)

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally))

;; (defun my-kill-ediff-buffers ()
;;   (kill-buffer ediff-buffer-A)
;;   (kill-buffer ediff-buffer-B)
;;   (kill-buffer ediff-buffer-C)
;;   (ediff-kill-buffer-carefully "*Ediff Control Panel*"))

;; (add-hook 'ediff-quit-hook 'my-kill-ediff-buffers)


(use-package fringe-helper)

;;
;; Bookmarks
;;
(use-package bm
  :init
  (setq bm-restore-repository-on-load t)

  :config
  (setq bm-highlight-style 'bm-highlight-only-fringe)
  ;; (setq bm-highlight-style 'bm-highlight-line-and-fringe)
  ;; (setq bm-marker 'bm-marker-left)
  (setq bm-marker 'bm-marker-right)

  (setq bm-cycle-all-buffers t)
  (setq bm-repository-file "~/.emacs.d/bookmarks")
  (setq-default bm-buffer-persistence t)

  (set-face-attribute 'bm-persistent-face nil
    :foreground "DarkGreen"
    :background "gray18")

  (set-face-attribute 'bm-fringe-persistent-face nil
    :foreground "DarkGreen"
    :background "gray18")

  (when (display-graphic-p) ; Add fringe only if display is graphic (GUI)
    (fringe-helper-define 'bm-marker-left nil
      "xx.xx..."
      ".xx.xx.."
      "..xx.xx."
      "...xx.xx"
      "..xx.xx."
      ".xx.xx.."
      "xx.xx..."
      )

    (fringe-helper-define 'bm-marker-right nil

      "...xx.xx"
      "..xx.xx."
      ".xx.xx.."
      "xx.xx..."
      ".xx.xx.."
      "..xx.xx."
      "...xx.xx"
      )
    )

  (add-hook 'after-init-hook 'bm-repository-load)

  (add-hook 'kill-buffer-hook #'bm-buffer-save)
  (add-hook 'after-save-hook #'bm-buffer-save)

  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore))


(use-package eval-expr)

(use-package magit)

(defun kill-magit-diff-buffer-in-current-repo (&rest _)
  "Delete the magit-diff buffer related to the current repo"
  (let ((magit-diff-buffer-in-current-repo
          (magit-mode-get-buffer 'magit-diff-mode)))
    (kill-buffer magit-diff-buffer-in-current-repo)))

(add-hook 'git-commit-setup-hook
  (lambda ()
    (add-hook 'with-editor-post-finish-hook #'kill-magit-diff-buffer-in-current-repo nil t)
    (add-hook 'with-editor-post-cancel-hook #'kill-magit-diff-buffer-in-current-repo nil t)))

;; liberated from https://github.com/fejfighter/fejfighter-emacs.d/blob/master/fejfighter-packages.el
(defun auto-display-magit-process-buffer (&rest args)
  "Automatically display the process buffer when it is updated."
  (let ((magit-display-buffer-noselect t))
    (magit-process-buffer)))

(advice-add 'magit-process-set-mode-line-error-status :before
  #'auto-display-magit-process-buffer)


(use-package repo)

(use-package goto-last-change)

(use-package clipmon
  :config
  (setq clipmon-autoinsert-color "red")
  (setq clipmon-autoinsert-timeout 2))

;;(require 'xclip)
;;(xclip-mode 1)
;;(turn-on-xclip)

(use-package auto-complete
  :init
  (require 'auto-complete-config)
  :diminish 'auto-complete-mode
  :config
  (ac-config-default)
  (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")
  (setq ac-modes '(emacs-lisp-mode
                   c-mode
                   cc-mode
                   c++-mode
                   python-mode
                   lua-mode))
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict"))

(use-package ac-emoji
  :config
  (add-hook 'markdown-mode-hook 'ac-emoji-setup)
  (add-hook 'git-commit-mode-hook 'ac-emoji-setup))

(use-package dirvish
  :config
  (dirvish-override-dired-mode))

;; (use-package which-key
;;   :diminish which-key-mode
;;   :config)

;; (use-package which-key-posframe
;;   :after (which-key posframe)
;;   :config
;;   (setq which-key-posframe-poshandler 'posframe-poshandler-frame-top-center)
;;   (which-key-posframe-mode))



(provide 'init-editor)
;;; init-editor.el ends here
