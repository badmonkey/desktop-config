;;; init-editor --- Configure editor features
;;; Commentary:
;;; Code:


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

(use-package magit
  :disabled t)

(use-package ibuffer)

(use-package crux
  :bind (("C-c u" . crux-view-url)
         ("C-c f c" . write-file)
         ("C-c f r" . crux-rename-buffer-and-file)
         ("C-c f d" . crux-delete-file-and-buffer)
         ;;("s-k"   . crux-kill-whole-line)
         ;;("s-o"   . crux-smart-open-line-above)
         ("C-a"   . crux-move-beginning-of-line)
         ([(shift return)] . crux-smart-open-line)
         ([(control shift return)] . crux-smart-open-line-above)))


(provide 'init-editor)
;;; init-editor.el ends here
