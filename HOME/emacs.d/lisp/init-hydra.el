;;; -*- lexical-binding: t; -*-
;;;
;;; init-hydra --- define hydras to be used with keybindings


(pretty-hydra-define hydra-magit
  (:hint nil :color teal :quit-key "q" :title (with-faicon "code-fork" "Git" 1 -0.05))
  ("Action"
    (("b" magit-blame "blame")
      ("c" magit-commit "commit")
      ("i" magit-init "init")
      ("l" magit-log-buffer-file "commit log (current file)")
      ("L" magit-log-current "commit log (project)")
      ("s" magit-status "status"))))


(pretty-hydra-define hydra-toggles
  (:color amaranth :quit-key "q" :title (with-faicon "toggle-on" "Toggles" 1 -0.05))
  ("Basic"
    (("w" whitespace-mode "whitespace" :toggle t)
      ("W" whitespace-cleanup-mode "whitespace cleanup" :toggle t)
      ("r" rainbow-mode "rainbow" :toggle t)
      ("L" page-break-lines-mode "page break lines" :toggle t))
    "Highlight"
    (("s" symbol-overlay-mode "symbol" :toggle t)
      ("l" hl-line-mode "line" :toggle t)
      ("x" highlight-sexp-mode "sexp" :toggle t)
      ("t" hl-todo-mode "todo" :toggle t))
    "Coding"
    (("p" smartparens-mode "smartparens" :toggle t)
      ("P" smartparens-strict-mode "smartparens strict" :toggle t)
      ("S" show-smartparens-mode "show smartparens" :toggle t)
      ("f" flycheck-mode "flycheck" :toggle t))))


;; (defhydra hydra-multiple-cursors (:color blue :hint nil)
;;   "
;;  Up^^             Down^^           Miscellaneous           % 2(mc/num-cursors) cursor%s(if (> (mc/num-cursors) 1) \"s\" \"\")
;; ------------------------------------------------------------------
;;  [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
;;  [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
;;  [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search
;;  [Click] Cursor at point       [_q_] Quit"
;;   ("l" mc/edit-lines :exit t)
;;   ("a" mc/mark-all-like-this :exit t)
;;   ("n" mc/mark-next-like-this)
;;   ("N" mc/skip-to-next-like-this)
;;   ("M-n" mc/unmark-next-like-this)
;;   ("p" mc/mark-previous-like-this)
;;   ("P" mc/skip-to-previous-like-this)
;;   ("M-p" mc/unmark-previous-like-this)
;;   ("s" mc/mark-all-in-region-regexp :exit t)
;;   ("0" mc/insert-numbers :exit t)
;;   ("A" mc/insert-letters :exit t)
;;   ("<mouse-1>" mc/add-cursor-on-click)
;;   ;; Help with click recognition in this hydra
;;   ("<down-mouse-1>" ignore)
;;   ("<drag-mouse-1>" ignore)
;;   ("q" nil))


(pretty-hydra-define hydra-mark
  (:color amaranth :title (with-faicon "arrows" "Expand Selection" 1 -0.05) :quit-key "q"
   :body-pre (call-interactively 'set-mark-command) :foreign-keys warn)
  ("Actions"
   (("SPC" hydra-multiple-cursors/body "Multicursor")
    ("=" er/expand-region "Expand")
    ("-" er/contract-region "Shrink")
    ("," exchange-point-and-mark "Swap Mark-Point")
    ("." (funcall 'set-mark-command t) "Set"))
   "Thing"
   (("w" er/mark-word "Word")
    ("c" er/mark-comment "Comment")
    ("s" er/mark-text-sentence "Sentence")
    ("t" er/mark-text-paragraph "Paragraph")
    ("u" er/mark-url "Url")
    ("m" er/mark-email "Email")
    ("`" er/mark-symbol "Symbol")
    ("f" er/mark-defun "Defun"))
   "Inside"
   (("[" er/mark-inside-pairs "Pairs")
    (";" er/mark-inside-quotes "Quotes"))
   "Outside"
   (("]" er/mark-outside-pairs "Pairs")
    ("'" er/mark-outside-quotes "Quotes"))))


(pretty-hydra-define hydra-flycheck
  (:hint nil :color teal :quit-key "q" :title (with-faicon "plane" "Flycheck" 1 -0.05))
  ("Checker"
    (("?" flycheck-describe-checker "describe")
      ("d" flycheck-disable-checker "disable")
      ("m" flycheck-mode "mode")
      ("s" flycheck-select-checker "select"))
    "Errors"
    (("<" flycheck-previous-error "previous" :color pink)
      (">" flycheck-next-error "next" :color pink)
      ("f" flycheck-buffer "check")
      ("l" flycheck-list-errors "list"))
    "Other"
    (("M" flycheck-manual "manual")
      ("v" flycheck-verify-setup "verify setup"))))


;; (defhydra hydra-help (:color blue :columns 8)
;;   "Help"
;;   ("f" describe-function "function")
;;   ("F" Info-goto-emacs-command-node "goto command")
;;   ("v" describe-variable "variable")
;;   ("m" describe-mode "mode")
;;   ("@" describe-face "face")
;;   ("k" describe-key "key")
;;   ("t" describe-theme "theme")
;;   ("b" describe-bindings "bindings")
;;   ("p" describe-package "package")
;;   ("d" helm-dash "dash")
;;   ("." helm-dash-at-point "dash at point"))


;; (pretty-hydra-define jp-window
;;   (:foreign-keys warn :title (with-faicon "windows" "Window Management" 1 -0.05) :quit-key "q")
;;   ("Actions"
;;    (("TAB" other-window "switch")
;;     ("x" ace-delete-window "delete")
;;     ("m" ace-delete-other-windows "maximize")
;;     ("s" ace-swap-window "swap")
;;     ("a" ace-select-window "select"))

;;    "Resize"
;;    (("h" move-border-left "←")
;;     ("j" move-border-down "↓")
;;     ("k" move-border-up "↑")
;;     ("l" move-border-right "→")
;;     ("n" balance-windows "balance")
;;     ("f" toggle-frame-fullscreen "toggle fullscreen"))

;;    "Split"
;;    (("b" split-window-right "horizontally")
;;     ("B" split-window-horizontally-instead "horizontally instead")
;;     ("v" split-window-below "vertically")
;;     ("V" split-window-vertically-instead "vertically instead"))

;;    "Zoom"
;;    (("+" zoom-in "in")
;;     ("=" zoom-in)
;;     ("-" zoom-out "out")
;;     ("0" jp-zoom-default "reset"))))



;; (pretty-hydra-define hydra-windows
;;   (:hint nil :forein-keys warn :quit-key "q" :title (with-faicon "windows" "Windows" 1 -0.05))
;;   ("Window"
;;    (("b" balance-windows "balance")
;;     ("i" enlarge-window "heighten")
;;     ("j" shrink-window-horizontally "narrow")
;;     ("k" shrink-window "lower")
;;     ("l" enlarge-window-horizontally "widen")
;;     ("s" switch-window-then-swap-buffer "swap" :color teal))
;;    "Zoom"
;;    (("-" text-scale-decrease "out")
;;     ("+" text-scale-increase "in")
;;     ("=" (text-scale-increase 0) "reset"))))


;; (pretty-hydra-define hydra-merge
;;   (:hint nil :color pink :quit-key "q" :title (with-alltheicon "git" "Merge" 1 -0.05))
;;   ("Move"
;;    (("n" smerge-next "next")
;;     ("p" smerge-prev "previous"))
;;    "Keep"
;;    (("RET" smerge-keep-current "current")
;;     ("a" smerge-keep-all "all")
;;     ("b" smerge-keep-base "base")
;;     ("l" smerge-keep-lower "lower")
;;     ("u" smerge-keep-upper "upper"))
;;    "Diff"
;;    (("<" smerge-diff-base-upper "upper/base")
;;     ("=" smerge-diff-upper-lower "upper/lower")
;;     (">" smerge-diff-base-lower "base/lower")
;;     ("R" smerge-refine "redefine")
;;     ("E" smerge-ediff "ediff"))
;;    "Other"
;;    (("C" smerge-combine-with-next "combine")
;;     ("r" smerge-resolve "resolve")
;;     ("k" smerge-kill-current "kill current"))))


;; (defhydra hydra-projectile3 (:color blue :columns 8)
;;   "Projectile"
;;   ("f" helm-projectile-find-file "find file")
;;   ("g" helm-projectile-find-file-dwim "find file dwim")
;;   ("F" helm-projectile-find-file-in-known-projects "file in projects")
;;   ("p" helm-projectile-switch-project "switch project")
;;   ("P" projectile-test-project "test")
;;   ("k" projectile-kill-buffers "kill buffers")
;;   ("a" helm-projectile-ag "ag")
;;   ("j" helm-projectile-switch-to-buffer "buffer"))


;; (pretty-hydra-define hydra-projectile2
;;   (:hint nil :color teal :quit-key "q" :title (with-faicon "rocket" "Projectile" 1 -0.05))
;;   ("Buffers"
;;    (("b" counsel-projectile-switch-to-buffer "list")
;;     ("k" projectile-kill-buffers "kill all")
;;     ("S" projectile-save-project-buffers "save all"))
;;    "Find"
;;    (("d" counsel-projectile-find-dir "directory")
;;     ("D" projectile-dired "root")
;;     ("f" counsel-projectile-find-file "file")
;;     ("p" counsel-projectile-switch-project "project"))
;;    "Other"
;;    (("i" projectile-invalidate-cache "reset cache"))
;;    "Search"
;;    (("r" projectile-replace "replace")
;;     ("R" projectile-replace-regexp "regexp replace")
;;     ("s" counsel-rg "search"))))



;; (defhydra hydra-projectile-other-window (:color teal)
;;   "projectile-other-window"
;;   ("f"  projectile-find-file-other-window        "file")
;;   ("g"  projectile-find-file-dwim-other-window   "file dwim")
;;   ("d"  projectile-find-dir-other-window         "dir")
;;   ("b"  projectile-switch-to-buffer-other-window "buffer")
;;   ("q"  nil                                      "cancel" :color blue))

;; (defhydra hydra-projectile (:color teal
;;                             :hint nil)
;;   "
;;      PROJECTILE: %(projectile-project-root)

;;      Find File            Search/Tags          Buffers                Cache
;; ------------------------------------------------------------------------------------------
;; _s-f_: file            _a_: ag                _i_: Ibuffer           _c_: cache clear
;;  _ff_: file dwim       _g_: update gtags      _b_: switch to buffer  _x_: remove known project
;;  _fd_: file curr dir   _o_: multi-occur     _s-k_: Kill all buffers  _X_: cleanup non-existing
;;   _r_: recent file                                               ^^^^_z_: cache current
;;   _d_: dir

;; "
;;   ("a"   projectile-ag)
;;   ("b"   projectile-switch-to-buffer)
;;   ("c"   projectile-invalidate-cache)
;;   ("d"   projectile-find-dir)
;;   ("s-f" projectile-find-file)
;;   ("ff"  projectile-find-file-dwim)
;;   ("fd"  projectile-find-file-in-directory)
;;   ("g"   ggtags-update-tags)
;;   ("s-g" ggtags-update-tags)
;;   ("i"   projectile-ibuffer)
;;   ("K"   projectile-kill-buffers)
;;   ("s-k" projectile-kill-buffers)
;;   ("m"   projectile-multi-occur)
;;   ("o"   projectile-multi-occur)
;;   ("s-p" projectile-switch-project "switch project")
;;   ("p"   projectile-switch-project)
;;   ("s"   projectile-switch-project)
;;   ("r"   projectile-recentf)
;;   ("x"   projectile-remove-known-project)
;;   ("X"   projectile-cleanup-known-projects)
;;   ("z"   projectile-cache-current-file)
;;   ("`"   hydra-projectile-other-window/body "other window")
;;   ("q"   nil "cancel" :color blue))



;; (pretty-hydra-define hydra-spelling
;;   (:hint nil :color teal :quit-key "q" :title (with-faicon "magic" "Spelling" 1 -0.05))
;;   ("Checker"
;;    (("c" langtool-correct-buffer "correction")
;;     ("C" langtool-check-done "clear")
;;     ("d" ispell-change-dictionary "dictionary")
;;     ("l" (message "Current language: %s (%s)" langtool-default-language ispell-current-dictionary) "language")
;;     ("s" my/switch-language "switch")
;;     ("w" wiki-summary "wiki"))
;;    "Errors"
;;    (("<" flyspell-correct-previous "previous" :color pink)
;;     (">" flyspell-correct-next "next" :color pink)
;;     ("f" langtool-check "find"))))



;; (defhydra hydra-helm (:hint nil :color pink)
;;         "
;;                                                                           ╭──────┐
;;    Navigation   Other  Sources     Mark             Do             Help   │ Helm │
;;   ╭───────────────────────────────────────────────────────────────────────┴──────╯
;;         ^_k_^         _K_       _p_   [_m_] mark         [_v_] view         [_H_] helm help
;;         ^^↑^^         ^↑^       ^↑^   [_t_] toggle all   [_d_] delete       [_s_] source help
;;     _h_ ←   → _l_     _c_       ^ ^   [_u_] unmark all   [_f_] follow: %(helm-attr 'follow)
;;         ^^↓^^         ^↓^       ^↓^    ^ ^               [_y_] yank selection
;;         ^_j_^         _J_       _n_    ^ ^               [_w_] toggle windows
;;   --------------------------------------------------------------------------------
;;         "
;;         ("<tab>" helm-keyboard-quit "back" :exit t)
;;         ("<escape>" nil "quit")
;;         ("\\" (insert "\\") "\\" :color blue)
;;         ("h" helm-beginning-of-buffer)
;;         ("j" helm-next-line)
;;         ("k" helm-previous-line)
;;         ("l" helm-end-of-buffer)
;;         ("g" helm-beginning-of-buffer)
;;         ("G" helm-end-of-buffer)
;;         ("n" helm-next-source)
;;         ("p" helm-previous-source)
;;         ("K" helm-scroll-other-window-down)
;;         ("J" helm-scroll-other-window)
;;         ("c" helm-recenter-top-bottom-other-window)
;;         ("m" helm-toggle-visible-mark)
;;         ("t" helm-toggle-all-marks)
;;         ("u" helm-unmark-all)
;;         ("H" helm-help)
;;         ("s" helm-buffer-help)
;;         ("v" helm-execute-persistent-action)
;;         ("d" helm-persistent-delete-marked)
;;         ("y" helm-yank-selection)
;;         ("w" helm-toggle-resplit-and-swap-windows)
;;         ("f" helm-follow-mode))



;; (defhydra dh-hydra-markdown-mode (:hint nil)
;;   "
;; Formatting        C-c C-s    _s_: bold          _e_: italic     _b_: blockquote   _p_: pre-formatted    _c_: code

;; Headings          C-c C-t    _h_: automatic     _1_: h1         _2_: h2           _3_: h3               _4_: h4

;; Lists             C-c C-x    _m_: insert item

;; Demote/Promote    C-c C-x    _l_: promote       _r_: demote     _u_: move up      _d_: move down

;; Links, footnotes  C-c C-a    _L_: link          _U_: uri        _F_: footnote     _W_: wiki-link      _R_: reference

;; "
;;   ("s" markdown-insert-bold)
;;   ("e" markdown-insert-italic)
;;   ("b" markdown-insert-blockquote :color blue)
;;   ("p" markdown-insert-pre :color blue)
;;   ("c" markdown-insert-code)

;;   ("h" markdown-insert-header-dwim)
;;   ("1" markdown-insert-header-atx-1)
;;   ("2" markdown-insert-header-atx-2)
;;   ("3" markdown-insert-header-atx-3)
;;   ("4" markdown-insert-header-atx-4)

;;   ("m" markdown-insert-list-item)

;;   ("l" markdown-promote)
;;   ("r" markdown-demote)
;;   ("d" markdown-move-down)
;;   ("u" markdown-move-up)

;;   ("L" markdown-insert-link :color blue)
;;   ("U" markdown-insert-uri :color blue)
;;   ("F" markdown-insert-footnote :color blue)
;;   ("W" markdown-insert-wiki-link :color blue)
;;   ("R" markdown-insert-reference-link-dwim :color blue)
;; )



;; (defhydra hydra-breadcrumb
;;   (:exit t)
;;   "
;; Breadcrumb bookmarks:
;;   _<up>_:   prev   _S-<up>_:   local prev
;;   _<down>_: next   _S-<down>_: local next
;;   _s_: set  _c_: clear  _l_: list  _q_: quit
;; "
;;   ("<down>" bc-next nil :exit nil)
;;   ("<up>" bc-previous nil :exit nil)
;;   ("S-<down>" bc-local-next nil :exit nil)
;;   ("S-<up>" bc-local-previous nil :exit nil)
;;   ("l" bc-list nil)
;;   ("s" bc-set nil)
;;   ("c" bc-clear nil)
;;   ("q" nil nil))


;; (defhydra hydra-straight-helper (:hint nil)
;;   "
;; _c_heck all       |_f_etch all     |_m_erge all      |_n_ormalize all   |p_u_sh all
;; _C_heck package   |_F_etch package |_M_erge package  |_N_ormlize package|p_U_sh package
;; ----------------^^+--------------^^+---------------^^+----------------^^+------------||_q_uit||
;; _r_ebuild all     |_p_ull all      |_v_ersions freeze|_w_atcher start   |_g_et recipe
;; _R_ebuild package |_P_ull package  |_V_ersions thaw  |_W_atcher quit    |prun_e_ build"
;;   ("c" straight-check-all)
;;   ("C" straight-check-package)
;;   ("r" straight-rebuild-all)
;;   ("R" straight-rebuild-package)
;;   ("f" straight-fetch-all)
;;   ("F" straight-fetch-package)
;;   ("p" straight-pull-all)
;;   ("P" straight-pull-package)
;;   ("m" straight-merge-all)
;;   ("M" straight-merge-package)
;;   ("n" straight-normalize-all)
;;   ("N" straight-normalize-package)
;;   ("u" straight-push-all)
;;   ("U" straight-push-package)
;;   ("v" straight-freeze-versions)
;;   ("V" straight-thaw-versions)
;;   ("w" straight-watcher-start)
;;   ("W" straight-watcher-quit)
;;   ("g" straight-get-recipe)
;;   ("e" straight-prune-build)
;;   ("q" nil))


(provide 'init-hydra)
;;; init-hydra.el ends here
