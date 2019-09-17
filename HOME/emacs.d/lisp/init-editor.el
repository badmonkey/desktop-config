;;; init-editor --- Configure editor features
;;; Commentary:
;;; Code:


(with-current-buffer "*scratch*"
	  (emacs-lock-mode 'kill))
(with-current-buffer "*Messages*"
	  (emacs-lock-mode 'kill))


(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)


(use-package dash)
(use-package dash-functional)


(use-package general)

(use-package key-chord
  :init
  (key-chord-mode 1))


;;; Hydra!

(use-package posframe
  ;; :load-path contrib-load-path
  :config)

(use-package hydra
  :config
  (use-package hydra-posframe
    :load-path contrib-load-path
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


(use-package crux)

(use-package revbufs
  :load-path contrib-load-path
  :config)

;; realgud
;; realgud-ipdb

;; (use-package electric
;;   :hook (prog-mode . electric-indent-mode))


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


(use-package magit
  :disabled t)

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



(provide 'init-editor)
;;; init-editor.el ends here
