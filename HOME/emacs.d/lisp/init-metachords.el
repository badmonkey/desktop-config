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
  )


;; M-TAB        spellcheck??


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


;; M-!				shell-command
;; M-$				ispell-word
;; M-%				query-replace
;; M-&				async-shell-command
;; M-'				abbrev-prefix-mark
;; M-(				insert-parentheses
;; M-)				move-past-close-and-reindent
;; M-,				xref-pop-marker-stack
;; M--				negative-argument


;;; M-.  at-point commands ;;;
(general-define-key
  :prefix "M-."
  :prefix-command 'at-point-keymap
  "TAB"     'completion-at-point
  "SPC"     'helm-dash-at-point
  "\\"      'bm-toggle

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-generate-docstring-at-point)
  "e"       'flycheck-display-error-at-point
  "g"       'google-this
  "p"       'pydoc-at-point
;; t        counsel-etags-find-tag-at-point
  "u"       'crux-view-url
  "x"       'exchange-point-and-mark
  "z"       'zeal-at-point
  )


;; (general-define-key
;;   :prefix "M-."
;;   :keymaps 'emacs-lisp-mode-map
;;   "f"       'srefactor-lisp-format-sexp)


;; M-/				dabbrev-expand
;; M-:				eval-expression


(general-define-key "M-;" 'comment-dwim)


;; M-<				beginning-of-buffer
;; M-=				count-words-region
;; M->				end-of-buffer
;; M-?				xref-find-references
;; M-@				mark-word


(general-define-key "M-\\" 'helm-bm)


;; M-^				delete-indentation
;; M-`				tmm-menubar
;; M-a
;; M-b          backward-word
;; M-c          capitalize-word
;; M-d          kill-word
;; M-e
;; M-f          forward-word


;;; M-g  goto commands ;;;
(general-define-key
  :prefix "M-g"
;; TAB      move-to-column

  "C-t"     'hl-todo-previous

  "1"       'flycheck-first-error
;; c        goto-char
;; g        goto-line
;; n        next-error
;; p        previous-error
  "t"       'hl-todo-next
  )


;; M-h
;; M-i
;; M-j


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


;; M-l
;; M-m
;; M-n


;;; M-o facemenu commands (replace? todo) ;;;


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
  "g"       'magit-status
  "l"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'load-current-buffer)
  "m"       'which-active-modes
  "o"       'counsel-find-file
  "p"       'projectile-switch-project
  "r"       'revbufs
  "v"       'venv-workon
  )


;; M-q


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
  :prefix "M-g"
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


;; M-t          transpose-words
;; M-u          upcase-word
;; M-v


;;; M-w  kill-ring commands ;;;
(general-define-key
  :prefix "M-w"
  :prefix-command 'killring-keymap
  "C-w"     'region-copy-whole-line

  "k"       'kill-whole-line
  "w"       'region-copy-line
  )


;; M-x          execute command -> counsel-M-x?
;; M-y          helm-show-kill-ring
;; M-z
;; M-{
;; M-|
;; M-}
;; M-~
;; M-DEL        backward-kill-word


;; map for buffer (content) commands
;; flycheck-buffer
;; flycheck-next-error
;; flycheck-previous-error



(provide 'init-metachords)
;;; init-metachords.el ends here
