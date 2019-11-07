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
  ((markdown-mode git-commit-mode) . fci-mode))


(use-package helm-ispell
  :after helm)


;; (use-package wiki-summary
;;   :defer 1
;;   :preface
;;   (defun my/format-summary-in-buffer (summary)
;;     "Given a summary, sticks it in the *wiki-summary* buffer and displays
;;      the buffer."
;;     (let ((buf (generate-new-buffer "*wiki-summary*")))
;;       (with-current-buffer buf
;;         (princ summary buf)
;;         (fill-paragraph)
;;         (goto-char (point-min))
;;         (view-mode))
;;       (pop-to-buffer buf))))

;; (advice-add 'wiki-summary/format-summary-in-buffer :override #'my/format-summary-in-buffer)



;; (use-package google-translate
;;   :bind
;;   ("M-o t" . google-translate-at-point)
;;   ("M-o T" . google-translate-at-point-reverse)
;;   :custom
;;   (google-translate-default-source-language "en")
;;   (google-translate-default-target-language "ja"))


;; (use-package bing-dict
;;   :straight t
;;   :bind (("C-c d" . bing-dict-brief))
;;   :init (setq bing-dict-show-thesaurus  'both
;;               bing-dict-vocabulary-save t
;;               bing-dict-cache-auto-save t
;;               bing-dict-vocabulary-file
;;               (no-littering-expand-var-file-name "bing-dict/vocabulary.org")
;;               bing-dict-cache-file
;;               (no-littering-expand-var-file-name "bing-dict/bing-dict-save.el")))
;; Spell
;; (if *ispell*
;;     (use-package ispell
;;       :init
;;       (setq-default ispell-program-name   *ispell*
;;                     ispell-silently-savep t
;;                     ispell-dictionary     "english"
;;                     ispell-personal-dictionary
;;                     (no-littering-expand-var-file-name "ispell/dictionary"))
;;       (when (string-suffix-p "aspell" *ispell*)
;;         (setq-default ispell-extra-args '("--reverse"))))
;;   (message "if you want to use ispell, try\n brew install aspell\n brew install ispell"))


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
