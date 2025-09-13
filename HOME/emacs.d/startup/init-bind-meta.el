;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-meta --- Add general meta bindings


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


(provide 'init-bind-meta)
;;; init-bind-meta.el ends here
