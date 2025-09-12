;;; -*- lexical-binding: t; -*-
;;;
;;; init-mode-markdown --- Configure markdown modes


(use-package markdown-mode
  :custom
  (markdown-hide-markup nil)
  (markdown-bold-underscore t)
  (markdown-italic-underscore t)
  (markdown-header-scaling t)
  (markdown-indent-function t)
  (markdown-enable-math t)
  (markdown-hide-urls nil)
  :custom-face
  (markdown-header-delimiter-face ((t (:foreground "mediumpurple"))))
  (markdown-header-face-1 ((t (:foreground "violet" :weight bold :height 1.0))))
  (markdown-header-face-2 ((t (:foreground "lightslateblue" :weight bold :height 1.0))))
  (markdown-header-face-3 ((t (:foreground "mediumpurple1" :weight bold :height 1.0))))
  (markdown-link-face ((t (:background "#0e1014" :foreground "#bd93f9"))))
  (markdown-list-face ((t (:foreground "mediumpurple"))))
  (markdown-pre-face ((t (:foreground "#bd98fe"))))
  :config
  (setq markdown-command "pandoc")
  ;; (setq markdown-command "vmd --stdin")
  ;; (setq markdown-command "redcarpet")
  :mode "\\.\\(m\\(ark\\)?down\\|md\\)$")

(use-package markdown-toc)


(use-package rst
  :config
  (add-hook 'rst-mode-hook
    (lambda ()
      (local-set-key (kbd "C-M-h") 'backward-kill-word)
      (setq-local fill-column 80)
      (turn-on-auto-fill))))


(provide 'init-mode-markdown)
;;; init-mode-markdown.el ends here
