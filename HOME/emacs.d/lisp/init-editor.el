;;; init-editor --- Configure editor features
;;; Commentary:
;;; Code:


(use-package general)

(general-define-key
  :prefix "ESC"
  "ESC" 'keyboard-quit)


;; (use-package which-key
;;   :init
;;   (which-key-mode)
;;   :diminish which-key-mode
;;   :config
;;   (which-key-setup-side-window-right-bottom)
;;   (setq which-key-sort-order 'which-key-key-order-alpha
;;         which-key-side-window-max-width 0.33
;;         which-key-idle-delay 0.05))


;; WIP
(use-package multiple-cursors)

(use-package mc-extras)

(use-package revbufs
  :load-path contrib-load-path
  :config)

(use-package rainbow-delimiters
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function rainbow-delimiters-mode "rainbow-delimiters.el"))
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package beacon
  :init (beacon-mode 1)
  :diminish beacon-mode)

(use-package hl-todo
  :load-path contrib-load-path
  :config
  (global-hl-todo-mode))

(use-package electric
  :hook (prog-mode . electric-indent-mode))

(use-package expand-region)

(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (ido-everywhere t)
  (ido-mode 1))

(use-package zeal-at-point)

(use-package google-this)

(use-package legalese)

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally))

;; (use-package undo-tree
;;   :diminish (undo-tree-mode)
;;   :init
;;   (progn
;;     (setq undo-tree-visualizer-relative-timestamps t)
;;     (setq undo-tree-visualizer-timestamps t)
;;     (setq undo-tree-visualizer-diff nil)

;;     (add-to-list
;;      'display-buffer-alist
;;      `(,(rx bos " *undo-tree*" eos)
;;        (display-buffer-in-side-window)
;;        (side . bottom)
;;        (window-height . 0.4)))))

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

(use-package crux)


(provide 'init-editor)
;;; init-editor.el ends here
