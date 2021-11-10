;;; init-metachords --- Add meta-chord bindings
;;; Commentary:
;;; Code:


(general-define-key
  :prefix "ESC"
  "ESC" 'keyboard-quit
  )


;; smart-backspace

(general-define-key
  "<home>"  'move-beginning-of-line
  "<end>"   'move-end-of-line

  "M-DEL"   'region-delete-back-word
  "<M-tab>" 'ac-complete-with-helm
  "M-RET"   'multi-term-dedicated-toggle
;; M-SPC region commands
;; M-. at-point commands
  "M-;"     'comment-dwim
  "M-\\"    'helm-bm
  "M-/"     'helm-dabbrev

  "M-="     'smart-region

  "M-a"     'unfill-region

  "M-c"     'subword-capitalize
;; M-g goto commands
;; M-k kill buffer commands
;; M-p project commands
  "M-q"     'fill-region-or-line
;; M-r replace commands
;; M-s search commands
;; M-t tag commands
;; M-u text commands
  "M-x"     'helm-M-x
  "M-y"     'helm-show-kill-ring
  )



;;; M-SPC  region commands ;;;
(general-define-key
  :prefix "M-SPC"
  :prefix-command 'bufferaction-keymap

  "SPC"     'smart-region
  "DEL"     'delete-region
  "TAB"     'indent-rigidly
  ";"       'region-toggle-comment
  "."       'hydra-mark/body

  "1"       'just-one-space

  "a"       'region-qp-decode

  "b"       'mc/edit-lines

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-region)

  "e"       'toggle-fancy-narrow

  "i"       'kill-inner-region
  "j"       'hydra-mark/body
  "k"       'region-kill-whole-line

  "m"       'mc/mark-all-like-this
  "n"       'narrow-to-region-indirect

  "o"       'kill-outer-region
  "p"       'mark-paragraph
  "q"       'region-qp-encode
  "w"       'region-copy-whole-line
  "M-w"     'kill-ring-save
  "y"       'clipmon-autoinsert-toggle
  )



;;; M-.  at-point commands ;;;
(general-define-key
  :prefix "M-."
  :prefix-command 'at-point-keymap

  "TAB"     'completion-at-point
  "SPC"     'helm-dash-at-point
  "\\"      'bm-annotate-or-create
  "?"       'symbol-at-point

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-generate-docstring-at-point)

  "e"       'flycheck-display-error-at-point
  "g"       'google-this

  "h"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'describe-function-at-point
              (derived-mode-p 'python-mode) 'pydoc-at-point)
  "i"       'helm-info-at-point

  "s"       'ispell-word
  ;; "t"       'ggtags-
  "u"       'crux-view-url
  "x"       'exchange-point-and-mark
  "z"       'zeal-at-point
  )


;; (general-define-key
;;   :prefix "M-."
;;   :keymaps 'emacs-lisp-mode-map
;;   "f"       'srefactor-lisp-format-sexp)



;;; M-g  goto commands ;;;
(general-define-key
  :prefix "M-g"

;; TAB      move-to-column
  "\\"      'goto-last-change
  "`"       'switch-to-last-buffer
  "["       'point-to-buffer-start
  "]"       'point-to-buffer-end

  "1"       'goto-line-with-prefix
  "2"       'goto-line-with-prefix
  "3"       'goto-line-with-prefix
  "4"       'goto-line-with-prefix
  "5"       'goto-line-with-prefix
  "6"       'goto-line-with-prefix
  "7"       'goto-line-with-prefix
  "8"       'goto-line-with-prefix
  "9"       'goto-line-with-prefix

;; c        goto-char
;; g        goto-line

;; n        next-error
;; p        previous-error
  "l"       'avy-goto-line
  "t"       'hl-todo-next
  "C-t"     'hl-todo-previous
  )



;;; M-k  kill buffer commands ;;;
(general-define-key
  :prefix "M-k"
  :prefix-command 'killbuffer-keymap
  "DEL"     'crux-delete-file-and-buffer

  "1"       'kill-other-buffers
  "a"       'kill-all-buffers
  "b"       'bury-buffer
  "f"       'kill-orphan-buffers
  "k"       'kill-or-bury-buffer
  "u"       'kill-unmodified-buffers
  "w"       'kill-with-linenum
  )



;;; M-p  project commands ;;;
(general-define-key
  :prefix "M-p"
  :prefix-command 'project-keymap

  "TAB"     'helm-recentf

  "RET"     (general-predicate-dispatch 'multi-term-dedicated-toggle
              (derived-mode-p 'python-mode) 'switch-to-python-shell)
  "."       'helm-mini

  ;; "]"       'flycheck-buffer
  "]"       'hydra-flycheck/body
  "["       'hl-todo-occur
  "1"       'toggle-window-dedicated
  "0"       'toggle-window-transparency

  "="       'toggle-frame-maximized
  "DEL"     'posframe-delete-all

  ;; "b"       'ibuffer

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer)

  "f"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'helm-pydoc)

  "g"       'projectile-ripgrep
  "i"       'projectile-project-info
  "k"       'hydra-toggles/body

  "l"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'load-current-buffer
              (derived-mode-p 'markdown-mode) 'markdown-live-preview-mode)

  "m"       'hydra-magit/body
  "o"       'helm-projectile-find-file
  "C-o"     'helm-find-files
  "p"       'projectile-switch-project
  "r"       'revbufs
  "s"       'ispell
  "t"       'transpose-windows
  "v"       'venv-workon
  "x"       'delete-window

  ;;  helm-buffers-list
  )



;;; M-r  replace commands ;;;
(general-define-key
  :prefix "M-r"
  :prefix-command 'replace-keymap

  "b"       'crux-rename-buffer-and-file
  "k"       'query-kill-matching-lines
  "r"       'query-replace-from-region
  "C-r"     'repeat-query-replace
  "x"       'query-replace-regexp
  "C-x"     'repeat-query-replace-regexp
  ;; replace with top of kill buffer
  )



;;; M-s  search commands ;;;
(general-define-key
  :prefix "M-s"

;; .        isearch-forward-symbol-at-point

  ;; o        occur
  "g"       'google-this-search
  "r"       'isearch-backward
  "C-r"     'isearch-backward-regexp
  "s"       'isearch-forward
;; t        counsel-etags-find-tag
;; C-t      counsel-etags-grep-symbol-at-point
  "x"       'isearch-forward-regexp
;; w        isearch-forward-word
  )



;;; M-t tag commands ;;;
(general-define-key
  :prefix "M-t"

  "."       'ggtags-find-tag-dwim
  "TAB"     'ggtags-view-search-history

  "c"       'ggtags-create-tags
  "d"       'ggtags-find-definition
  "o"       'imenu-anywhere
  "r"       'ggtags-query-replace
  "u"       'ggtags-update-tags
  "x"       'ggtags-explain-tags
  )



;;; M-u  text commands ;;;
(general-define-key
  :prefix "M-u"
  :prefix-command 'text-keymap

  "TAB"     'untabify-everything

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'markdown-mode) 'markdown-toc-delete-toc)

  "f"       'fill-region-or-line

  "g"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer
              (derived-mode-p 'markdown-mode) 'markdown-toc-generate-toc)

  "l"       'region-downcase-word

  "r"       (general-predicate-dispatch nil
              (derived-mode-p 'markdown-mode) 'markdown-toc-refresh-toc)

  "s"       'ispell-region-or-line
  "t"       'transpose-words
  "u"       'region-upcase-word
  )



(provide 'init-metachords)
;;; init-metachords.el ends here
