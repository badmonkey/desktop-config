;;; init-metachords --- Add meta-chord bindings
;;; Commentary:
;;; Code:


(general-define-key
  "M-DEL"   'region-delete-back-word
  "<M-tab>" 'ac-complete-with-helm)


;; M-TAB        spellcheck??


;;; M-SPC  region commands ;;;
(general-define-key
  :prefix "M-SPC"
  :prefix-command 'bufferaction-keymap
  "1"       'just-one-space
  "SPC"     'set-mark-command
  "DEL"     'delete-region
  "w"       'region-copy-line
  "k"       'region-kill-whole-line
  ";"       'region-toggle-comment
  "TAB"     'indent-rigidly
  "p"       'mark-paragraph
  "M-w"     'kill-ring-save
  "m"       'mc/mark-all-like-this
  "e"       'mc/edit-lines)


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
  "z"       'zeal-at-point
  "g"       'google-this
  "TAB"     'completion-at-point
  "x"       'exchange-point-and-mark
  "p"       'pydoc-at-point
  "e"       'flycheck-display-error-at-point
  "SPC"     'helm-dash-at-point
  "\\"      'bm-toggle
  "u"       'crux-view-url)
;; t        counsel-etags-find-tag-at-point


;; M-/				dabbrev-expand
;; M-:				eval-expression


;;; M-;  comment commands ;;;
(general-define-key
  :prefix "M-;"
  :prefix-command 'comment-keymap
  "TAB"     'comment-dwim
  ";"       'region-toggle-comment)


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
  "1"       'flycheck-first-error
  "t"       'hl-todo-next
  "C-t"     'hl-todo-previous)
;; g        goto-line
;; c        goto-char
;; TAB      move-to-column
;; n        next-error
;; p        previous-error


;; M-h
;; M-i
;; M-j


;;; M-k  kill buffer commands ;;;
(general-define-key
  :prefix "M-k"
  :prefix-command 'killbuffer-keymap
  "k"       'kill-buffer
  "a"       'kill-all-buffers
  "1"       'kill-other-buffers
  "u"       'kill-unmodified-buffers
  "o"       'kill-orphan-buffers
  "DEL"     'crux-delete-file-and-buffer)


;; M-l
;; M-m
;; M-n


;;; M-o facemenu commands (replace? todo) ;;;


;;; M-p  project commands ;;;
(general-define-key
  :prefix "M-p"
  :prefix-command 'project-keymap
  "r"       'revbufs
  "g"       'magit-status
  "o"       'counsel-find-file
  "f"       'neotree
  "b"       'ibuffer
  "l"       'flycheck-buffer
  "t"       'hl-todo-occur
  "p"       'projectile-switch-project
  "TAB"     'helm-projectile-find-file)




;; M-q


;;; M-r  replace commands ;;;
(general-define-key
  :prefix "M-r"
  :prefix-command 'replace-keymap
  "r"       'query-replace-from-region
  "x"       'query-replace-regexp
  "b"       'crux-rename-buffer-and-file
  "k"       'query-kill-matching-lines)


;;; M-s  search commands;;;
(general-define-key
  :prefix "M-g"
  "s"       'isearch-forward
  "x"       'isearch-forward-regexp
  "r"       'isearch-backward
  "C-r"     'isearch-backward-regexp)
;; C-t      counsel-etags-grep-symbol-at-point
;; t        counsel-etags-find-tag
;; .        isearch-forward-symbol-at-point
;; w        isearch-forward-word
;; o        occur


;; M-t          transpose-words
;; M-u          upcase-word
;; M-v


;;; M-w  kill-ring commands ;;;
(general-define-key
  :prefix "M-w"
  :prefix-command 'killring-keymap
  "w"       'region-copy-line
  "C-w"     'region-copy-whole-line
  "k"       'kill-whole-line)


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
