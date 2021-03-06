;;; init-editor --- Configure editor features
;;; Commentary:
;;; Code:

;; https://github.com/jpkotta/syntax-subword/tree/9aa9b3f846bfe2474370642458a693ac4760d9fe
;; https://github.com/akicho8/string-inflection/tree/c4a519be102cb99dd86be3ee8c387f008d097635
;; https://github.com/knu/replace-with-inflections.el/tree/d9201e047856492f282da65459b28aba25998dbb


(with-current-buffer "*scratch*"
	  (emacs-lock-mode 'kill))
(with-current-buffer "*Messages*"
	  (emacs-lock-mode 'kill))


(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)


(use-package general)

(use-package key-chord
  :init
  (key-chord-mode 1))


;;; Hydra!

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

(use-package multiple-cursors)

(use-package expand-region)

(use-package smart-region)

(use-package change-inner)


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
  :load-path contrib-load-path
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


(use-package fringe-helper)

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
    ;; (fringe-helper-define 'bm-marker-left '(top repeat)
    ;;   "....XXXX"
    ;;   "....XXXX"
    ;;   "....XXXX"
    ;;   "....XXXX"
    ;;   )

    (fringe-helper-define 'bm-marker-left nil
      "xx.xx..."
      ".xx.xx.."
      "..xx.xx."
      "...xx.xx"
      "..xx.xx."
      ".xx.xx.."
      "xx.xx..."
      )

    ;; (fringe-helper-define 'bm-marker-right '(top repeat)
    ;;   "XXXX...."
    ;;   "XXXX...."
    ;;   "XXXX...."
    ;;   "XXXX...."
    ;;   )

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


;; yasnippet
;; (use-package yasnippet
;;   :straight t
;;   :bind
;;   (:map yas-minor-mode-map
;;         ("<tab>" . nil)
;;         ("TAB" . nil))
;;   :hook (yas-before-expand-snippet . expand-for-web-mode)
;;   :config
;;   (yas-global-mode)

;;   )

(use-package magit)

(use-package goto-last-change)

(use-package clipmon
  :config
  (setq clipmon-autoinsert-color "red")
  (setq clipmon-autoinsert-timeout 2))

;;(require 'xclip)
;;(xclip-mode 1)
;;(turn-on-xclip)

(use-package ibuffer)

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


;; (use-package which-key
;;   :diminish which-key-mode
;;   :config
;;   (which-key-mode))

;; (use-package which-key-posframe
;;   :after (which-key posframe)
;;   :config
;;   (setq which-key-posframe-poshandler 'posframe-poshandler-window-top-right-corner)
;;   (which-key-posframe-mode))



(provide 'init-editor)
;;; init-editor.el ends here
