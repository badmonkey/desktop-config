;;; init-text --- Configure text modes
;;; Commentary:
;;; Code:



(use-package markdown-mode
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config)

(use-package rst
  :config
  (add-hook 'rst-mode-hook
            (lambda ()
              (local-set-key (kbd "C-M-h") 'backward-kill-word)
              (setq-local fill-column 80)
              (turn-on-auto-fill))))


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
