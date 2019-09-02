;;; init-text --- Configure text modes
;;; Commentary:
;;; Code:



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


(use-package fill-column-indicator
  :hook
  ((markdown-mode
    git-commit-mode) . fci-mode))


;; (flycheck-define-checker textlint
;;   "A linter for textlint."
;;   :command ("npx" "textlint"
;;             "--config" "/home/rob/.emacs.d/.textlintrc"
;;             "--format" "unix"
;;             "--rule" "write-good"
;;             "--rule" "no-start-duplicated-conjunction"
;;             "--rule" "max-comma"
;;             "--rule" "terminology"
;;             "--rule" "period-in-list-item"
;;             "--rule" "abbr-within-parentheses"
;;             "--rule" "alex"
;;             "--rule" "common-misspellings"
;;             "--rule" "en-max-word-count"
;;             "--rule" "diacritics"
;;             "--rule" "stop-words"
;;             "--plugin"
;;             (eval
;;              (if (derived-mode-p 'tex-mode)
;;                  "latex"
;;                "@textlint/text"))
;;             source-inplace)
;;   :error-patterns
;;   ((warning line-start (file-name) ":" line ":" column ": "
;;             (message (one-or-more not-newline)
;;                      (zero-or-more "\n" (any " ") (one-or-more not-newline)))
;;             line-end))
;;   :modes (text-mode latex-mode org-mode markdown-mode)
;;   )
;; (add-to-list 'flycheck-checkers 'textlint)

;; https://www.macs.hw.ac.uk/~rs46/posts/2018-12-29-textlint-flycheck.html


(provide 'init-text)
;;; init-text.el ends here
