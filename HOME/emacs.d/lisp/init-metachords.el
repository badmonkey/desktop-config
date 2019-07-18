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

  "M-`"     'switch-to-last-buffer

  "M-q"     'fill-region-or-line
  )



;;; M-SPC  region commands ;;;
(general-define-key
  :prefix "M-SPC"
  :prefix-command 'bufferaction-keymap

  "SPC"     'set-mark-command
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
  "w"       'region-copy-line
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

  "`"       'point-to-buffer-start
  "."       'point-to-buffer-end
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

  "TAB"     'helm-projectile-find-file

  "RET"     (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'switch-to-python-shell)

  "]"       'flycheck-buffer
  "["       'hl-todo-occur

  "b"       'ibuffer

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer)

  "f"       'neotree
  ;; "g"       'magit-status   ;; TODO not a commandp?

  "i"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'helm-pydoc)

  "l"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'load-current-buffer)

  "m"       'which-active-modes
  ;; "o"       'counsel-find-file   ;; TODO not a commandp?
  "p"       'projectile-switch-project
  "r"       'revbufs
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



;;; M-w  kill-ring commands ;;;
(general-define-key
  :prefix "M-w"
  :prefix-command 'killring-keymap

  "C-w"     'region-copy-whole-line

  "k"       'kill-whole-line
  "w"       'region-copy-line
  )



(provide 'init-metachords)
;;; init-metachords.el ends here
