;;; init-metachords --- Add meta-chord bindings
;;; Commentary:
;;; Code:


(general-define-key
  :prefix "ESC"
  "ESC" 'keyboard-quit
  )


(general-define-key
  "<home>"  'move-beginning-of-line
  "<end>"   'move-end-of-line

  "M-DEL"   'region-delete-back-word
  "<M-tab>" 'ac-complete-with-helm
  "M-RET"   'multi-term-dedicated-toggle
  "M-;"     'comment-dwim
  "M-\\"    'helm-bm

  "M-a"     'unfill-region

  "M-c"     'subword-capitalize
  "M-q"     'fill-region-or-line
  "M-x"     'helm-M-x


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

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-region)

  "e"       'mc/edit-lines
  "i"       'kill-inner-region
  "j"       'hydra-mark/body
  "k"       'region-kill-whole-line
  "m"       'mc/mark-all-like-this
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

  "1"       'flycheck-first-error

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
  )



;;; M-p  project commands ;;;
(general-define-key
  :prefix "M-p"
  :prefix-command 'project-keymap

  "TAB"     'neotree

  "RET"     (general-predicate-dispatch 'multi-term-dedicated-toggle
              (derived-mode-p 'python-mode) 'switch-to-python-shell)

  ;; "]"       'flycheck-buffer
  "]"       'hydra-flycheck/body
  "["       'hl-todo-occur
  "-"       'posframe-delete-all

  "b"       'ibuffer

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
  "p"       'projectile-switch-project
  "r"       'revbufs
  "s"       'ispell
  "t"       'transpose-windows
  "v"       'venv-workon
  "x"       'delete-window
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
  )



;;; M-s  search commands;;;
(general-define-key
  :prefix "M-s"

;; .        isearch-forward-symbol-at-point

;; o        occur
  "r"       'isearch-backward
  "C-r"     'isearch-backward-regexp
  "s"       'isearch-forward
;; t        counsel-etags-find-tag
;; C-t      counsel-etags-grep-symbol-at-point
  "x"       'isearch-forward-regexp
;; w        isearch-forward-word
  )



;;; M-t transpose-word
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
