;;; init-metachords --- Add meta-chord bindings
;;; Commentary:
;;; Code:


(general-define-key
  :prefix "ESC"
  "ESC" 'keyboard-quit
  )


(general-define-key
  "M-DEL"   'region-delete-back-word
  "<M-tab>" 'ac-complete-with-helm
  "M-RET"   'ansi-term

  "M-;"     'comment-dwim
  "M-\\"    'helm-bm

  "M-q"     'fill-region-or-line
  )



;;; M-SPC  region commands ;;;
(general-define-key
  :prefix "M-SPC"
  :prefix-command 'bufferaction-keymap

  "M-SPC"   'smart-region
  "SPC"     'smart-region
  "DEL"     'delete-region
  "TAB"     'indent-rigidly
  ";"       'region-toggle-comment

  "M-w"     'kill-ring-save

  "1"       'just-one-space

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-region)

  "e"       'mc/edit-lines
  "k"       'region-kill-whole-line
  "m"       'mc/mark-all-like-this
  "p"       'mark-paragraph
  "w"       'region-copy-whole-line
  )



;;; M-.  at-point commands ;;;
(general-define-key
  :prefix "M-."
  :prefix-command 'at-point-keymap

  "TAB"     'completion-at-point
  "SPC"     'helm-dash-at-point
  "\\"      'bm-annotate-or-create

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-generate-docstring-at-point)

  "e"       'flycheck-display-error-at-point
  "g"       'google-this

  "h"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'describe-function-at-point
              (derived-mode-p 'python-mode) 'pydoc-at-point)

;; t        counsel-etags-find-tag-at-point   ;; TODO missing?
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

  "1"       'flycheck-first-error
;; c        goto-char
;; g        goto-line

;; n        next-error
;; p        previous-error

  "t"       'hl-todo-next
  "C-t"     'hl-todo-previous

  "`"       'switch-to-last-buffer

  "["       'point-to-buffer-start
  "]"       'point-to-buffer-end
  )



;;; M-k  kill buffer commands ;;;
(general-define-key
  :prefix "M-k"
  :prefix-command 'killbuffer-keymap
  "DEL"     'crux-delete-file-and-buffer

  "1"       'kill-other-buffers
  "a"       'kill-all-buffers
  "b"       'bury-buffer
  "k"       'kill-or-bury-buffer
  "o"       'kill-orphan-buffers
  "u"       'kill-unmodified-buffers
  )



;;; M-p  project commands ;;;
(general-define-key
  :prefix "M-p"
  :prefix-command 'project-keymap

  "TAB"     'neotree

  "RET"     (general-predicate-dispatch 'ansi-term
              (derived-mode-p 'python-mode) 'switch-to-python-shell)

  ;; "]"       'flycheck-buffer
  "]"       'hydra-flycheck/body
  "["       'hl-todo-occur

  "b"       'ibuffer

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer)

  ;; "g"       'magit-status   ;; TODO not a commandp?

  "i"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'helm-pydoc)

  "l"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'load-current-buffer
              (derived-mode-p 'markdown-mode) 'markdown-live-preview-mode)

  "o"       'helm-projectile-find-file
  "p"       'projectile-switch-project
  "r"       'revbufs
  "s"       'projectile-ripgrep
  "t"       'transpose-windows
  "v"       'venv-workon
  )



;;; M-r  replace commands ;;;
(general-define-key
  :prefix "M-r"
  :prefix-command 'replace-keymap

  "b"       'crux-rename-buffer-and-file
  "k"       'query-kill-matching-lines
  "r"       'query-replace-from-region
  "x"       'query-replace-regexp
  )



;;; M-s  search commands;;;
(general-define-key
  :prefix "M-s"

;; .        isearch-forward-symbol-at-point

  "C-r"     'isearch-backward-regexp
;; C-t      counsel-etags-grep-symbol-at-point

;; o        occur
  "r"       'isearch-backward
  "s"       'isearch-forward
;; t        counsel-etags-find-tag
  "x"       'isearch-forward-regexp
;; w        isearch-forward-word
  )



;;; M-t transpose-word
(general-unbind
  "M-t"
  )



;;; M-u  text commands ;;;
(general-define-key
  :prefix "M-u"
  :prefix-command 'text-keymap
  "u"       'region-upcase-word
  "l"       'region-downcase-word

  "t"       'transpose-words
  "f"       'fill-region-or-line

  "g"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer
              (derived-mode-p 'markdown-mode) 'markdown-toc-generate-toc)

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'markdown-mode) 'markdown-toc-delete-toc)

  "f"       (general-predicate-dispatch nil
              (derived-mode-p 'markdown-mode) 'markdown-toc-refresh-toc)
  )



(provide 'init-metachords)
;;; init-metachords.el ends here
