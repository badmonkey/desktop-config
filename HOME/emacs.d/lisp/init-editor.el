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

(use-package hydra)

(use-package pretty-hydra
  :load-path contrib-load-path
  :config)


;; WIP
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
