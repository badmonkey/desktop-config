;;; -*- lexical-binding: t; -*-
;;;
;;; init-metachords --- Add meta-chord bindings

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
  "<M-up>"    'region-join-lines
  ;; M-SPC      region commands
  ;; M-!    shell-command
  ;; M-$    ispell-word
  ;; M-%    query-replace
  ;; M-&    async-shell-command
  ;; M-'    abbrev-prefix-mark
  ;; M-(    insert-parentheses
  ;; M-)    move-past-close-and-reindent
  ;; M-,    xref-go-back
  ;; M-.        at-point commands
  ;; M--    negative-argument
  "M-/"     'helm-dabbrev
  ;; M-:    eval-expression
  "M-;"     'comment-dwim
  ;; M-<    beginning-of-buffer
  "M-="     'smart-region
  ;; M->    end-of-buffer
  ;; M-?    xref-find-references
  ;; M-@    mark-word
  "M-\\"    'helm-bm
  ;; M-^    delete-indentation
  ;; M-`    tmm-menubar
  ;; M-{    backward-paragraph
  ;; M-|    shell-command-on-region
  ;; M-}    forward-paragraph
  ;; M-~    not-modified

  "M-a"     'unfill-region
  ;; M-b    backward-word
  "M-c"     'subword-capitalize
  ;; M-d    kill-word
  ;; M-e    forward-sentence
  ;; M-f    forward-word
  ;; M-g        goto commands
  ;; M-h    mark-paragraph
  ;; M-i    tab-to-tab-stop
  ;; M-j    default-indent-new-line
  ;; M-k        kill buffer commands
  ;; M-l    downcase-word
  ;; M-m    back-to-indentation
  ;; M-n
  ;; M-o
  ;; M-p        project commands
  "M-q"     'fill-region-or-line
  ;; M-r        replace commands
  ;; M-s        search commands
  ;; M-t        tag commands
  ;; M-u        text commands
  ;; M-v    scroll-down-command
  ;; M-w    kill-ring-save
  "M-x"     'helm-M-x
  "M-y"     'helm-show-kill-ring
  ;; M-z    zap-to-char
  )



;;; M-SPC  region commands ;;;
(general-define-key
  :prefix "M-SPC"
  :prefix-command 'bufferaction-keymap

  "SPC"     'smart-region
  "DEL"     'delete-region
  "TAB"     'indent-rigidly

  ";"       'region-toggle-comment

  "0"       'mark-sexp
  "1"       'just-one-space

  "a"       'region-qp-decode

  "b"       'mc/edit-lines

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-region)

  "e"       'toggle-fancy-narrow

  "i"       'kill-inner-region
  "j"       'region-join-lines
  "k"       'region-kill-whole-line

  "m"       'hydra-mark/body
  "n"       'narrow-to-region-indirect

  "o"       'kill-outer-region
  "p"       'mark-paragraph
  "q"       'region-qp-encode
  "s"       'mc/mark-all-like-this
  "w"       'region-copy-whole-line
  "y"       'clipmon-autoinsert-toggle
  )



;;; M-.  at-point commands ;;;
(general-define-key
  :prefix "M-."
  :prefix-command 'at-point-keymap

  "TAB"     'completion-at-point
  "SPC"     'just-one-space
  "DEL"     'delete-horizontal-space

  "<left>"  'delete-ws-right
  "["       'delete-ws-right
  "]"       'delete-ws-left

  "/"       'helm-dash-at-point
  "\\"      'bm-annotate-or-create
  "?"       'symbol-at-point

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-generate-docstring-at-point)

  "e"       'flycheck-display-error-at-point
  ;;"f"       'xref-...
  "g"       'google-this

  "h"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'describe-function-at-point
              (derived-mode-p 'python-mode) 'pydoc-at-point)
  "i"       'helm-info-at-point

  "s"       'ispell-word
  ;; "t"    'ggtags- ??
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

  ;; TAB    move-to-column
  "\\"      'goto-last-change
  "`"       'switch-to-last-buffer
  "["       'point-to-buffer-start
  "]"       'point-to-buffer-end

  ","       'backward-list
  "."       'forward-list

  "1"       'goto-line-with-prefix
  "2"       'goto-line-with-prefix
  "3"       'goto-line-with-prefix
  "4"       'goto-line-with-prefix
  "5"       'goto-line-with-prefix
  "6"       'goto-line-with-prefix
  "7"       'goto-line-with-prefix
  "8"       'goto-line-with-prefix
  "9"       'goto-line-with-prefix

  ;; c      goto-char
  ;; g      goto-line

  ;; i      imenu

  "j"       'avy-goto-line
  "l"       'dogears-go

  ;; n      next-error
  ;; p      previous-error

  "t"       'hl-todo-next
  "C-t"     'hl-todo-previous
  )



;;; M-k  kill buffer commands ;;;
(general-define-key
  :prefix "M-k"
  :prefix-command 'killbuffer-keymap
  "DEL"     'crux-delete-file-and-buffer

  "0"       'kill-all-buffers
  "1"       'kill-other-buffers

  "b"       'bury-buffer
  "k"       'kill-or-bury-buffer
  "o"       'kill-orphan-buffers
  "p"       'projectile-kill-buffers
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

  "0"       'toggle-window-transparency
  "1"       'toggle-window-dedicated
  "="       'toggle-frame-maximized

  ;; "]"    'flycheck-buffer ??
  "]"       'hydra-flycheck/body
  "["       'hl-todo-occur

  "DEL"     'posframe-delete-all

  ;; "b"    'ibuffer ??

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer)

  "f"       (general-predicate-dispatch 'helm-find-files
              (projectile-project-p) 'helm-projectile-find-file)
  "F"       (general-predicate-dispatch 'helm-find-files
              (projectile-project-p) 'helm-projectile-find-file-in-known-projects)

  "h"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'helm-pydoc)

  "g"       'projectile-ripgrep
  "i"       'projectile-project-info
  "k"       'hydra-toggles/body

  "l"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'load-current-buffer
              (derived-mode-p 'markdown-mode) 'markdown-live-preview-mode)

  "m"       'hydra-magit/body

  "o"       (general-predicate-dispatch 'helm-for-files
              (projectile-project-p) 'helm-projectile)

  "p"       'helm-projectile-switch-project
  "q"       'neotree-toggle
  "r"       'revbufs
  "s"       'ispell
  "t"       'transpose-windows
  "u"       'desktop-save
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

  ;; .      isearch-forward-symbol-at-point
  ;; _      isearch-forward-symbol

  ;; "f"       'xref-find -apropos -definitions
  "g"       'google-this-search
  ;; o      occur
  "r"       'isearch-backward
  "C-r"     'isearch-backward-regexp
  "s"       'isearch-forward
  ;; t      counsel-etags-find-tag ??
  ;; C-t    counsel-etags-grep-symbol-at-point ??
  ;; w      isearch-forward-word
  "x"       'isearch-forward-regexp
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
