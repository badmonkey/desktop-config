;;; init-metachords --- Add meta-chord bindings
;;; Commentary:
;;; Code:



(global-set-key (kbd "<M-backspace>") 'region-delete-back-word)

;; M-TAB        spellcheck??


;;; M-SPC  region commands ;;;
(define-prefix-command 'buffer-action-keymap)
(global-set-key (kbd "M-SPC") 'buffer-action-keymap)

(global-set-key (kbd "M-SPC 1") 'just-one-space)
(global-set-key (kbd "M-SPC SPC") 'set-mark-command)
(global-set-key (kbd "M-SPC w") 'kill-region)
(global-set-key (kbd "M-SPC M-w") 'kill-ring-save)
(global-set-key (kbd "M-SPC ;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-SPC TAB") 'my-indent-rigidly)
(global-set-key (kbd "M-SPC p") 'mark-paragraph)


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
(define-prefix-command 'at-point-keymap)
(global-set-key (kbd "M-.") 'at-point-keymap)

(global-set-key (kbd "M-. z") 'zeal-at-point)
(global-set-key (kbd "M-. g") 'google-this)
(global-set-key (kbd "M-. TAB") 'completion-at-point)
(global-set-key (kbd "M-. x") 'exchange-point-and-mark)
(global-set-key (kbd "M-. d") 'pydoc-at-point)
(global-set-key (kbd "M-. e") 'flycheck-display-error-at-point)
;; M-. t        counsel-etags-find-tag-at-point
;; M-. SPC      helm-dash-at-point


;; M-/				dabbrev-expand
;; M-:				eval-expression


;;; M-;  comment commands ;;;
(define-prefix-command 'comment-keymap)
(global-set-key (kbd "M-;") 'comment-keymap)

(global-set-key (kbd "M-; TAB") 'comment-dwim)
(global-set-key (kbd "M-; ;") 'comment-or-uncomment-line)
(global-set-key (kbd "M-; SPC") 'comment-or-uncomment-region)


;; M-<				beginning-of-buffer
;; M-=				count-words-region
;; M->				end-of-buffer
;; M-?				xref-find-references
;; M-@				mark-word
;; M-\				delete-horizontal-space
;; M-^				delete-indentation
;; M-`				tmm-menubar
;; M-a
;; M-b          backward-word
;; M-c          capitalize-word
;; M-d          kill-word
;; M-e
;; M-f          forward-word


;;; M-g  goto commands ;;;
(global-set-key (kbd "M-g 1") 'flycheck-first-error)
(global-set-key (kbd "M-g t") 'hl-todo-next)
(global-set-key (kbd "M-g C-t") 'hl-todo-previous)
;; M-g g        goto-line
;; M-g c        goto-char
;; M-g TAB      move-to-column
;; M-g n        next-error
;; M-g p        previous-error


;; M-h
;; M-i
;; M-j


;;; M-k  kill buffer commands ;;;
(define-prefix-command 'killbuffer-keymap)
(global-set-key (kbd "M-k") 'killbuffer-keymap)

(global-set-key (kbd "M-k k") 'kill-buffer)
(global-set-key (kbd "M-k a") 'kill-all-buffers)
(global-set-key (kbd "M-k 1") 'kill-other-buffers)
(global-set-key (kbd "M-k u") 'kill-unmodified-buffers)
(global-set-key (kbd "M-k o") 'kill-orphan-buffers)
(global-set-key (kbd "M-k DEL") 'crux-delete-file-and-buffer)


;; M-l
;; M-m
;; M-n


;;; M-o facemenu commands (replace? todo) ;;;


;;; M-p  project commands ;;;
(define-prefix-command 'project-keymap)
(global-set-key (kbd "M-p") 'project-keymap)

(global-set-key (kbd "M-p r") 'revbufs)
(global-set-key (kbd "M-p g") 'magit-status)
(global-set-key (kbd "M-p o") 'counsel-find-file)
(global-set-key (kbd "M-p b") 'ibuffer)
(global-set-key (kbd "M-p l") 'flycheck-buffer)
(global-set-key (kbd "M-p t") 'hl-todo-occur)
(global-set-key (kbd "M-p p") 'projectile-switch-project)
;; M-p f        neotree
;; M-p TAB      helm-projectile-find-file


;; M-q


;;; M-r  replace commands ;;;
(define-prefix-command 'replace-keymap)
(global-set-key (kbd "M-r") 'replace-keymap)

(global-set-key (kbd "M-r r") 'query-replace)
(global-set-key (kbd "M-r x") 'query-replace-regexp)
(global-set-key (kbd "M-r b") 'crux-rename-buffer-and-file)


;;; M-s  search commands (extend) ;;;
(global-set-key (kbd "M-s s") 'isearch-forward)
(global-set-key (kbd "M-s x") 'isearch-forward-regexp)
(global-set-key (kbd "M-s r") 'isearch-backward)
(global-set-key (kbd "M-s C-r") 'isearch-backward-regexp)
;; M-s C-t      counsel-etags-grep-symbol-at-point
;; M-s t        counsel-etags-find-tag
;; M-s .        isearch-forward-symbol-at-point
;; M-s w        isearch-forward-word
;; M-s o        occur


;; M-t          transpose-words
;; M-u          upcase-word
;; M-v


;;; M-w  kill-ring commands ;;;
(define-prefix-command 'killring-keymap)
(global-set-key (kbd "M-w") 'killring-keymap)

(global-set-key (kbd "M-w w") 'region-copy-whole-line)
(global-set-key (kbd "M-w k") 'kill-whole-line)


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
