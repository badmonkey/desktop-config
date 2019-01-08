
;;; Code:
(setq gc-cons-threshold 100000000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize the package system.

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; For important compatibility libraries like cl-lib
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; Bootstrap `use-package'.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Add custom code to the load path. `contrib' contains Lisp code that I didn't
;; write but that is not in melpa, while `lisp' is for Lisp code I wrote.
(setq contrib-load-path (expand-file-name "contrib" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "contrib" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))


;; Make use-package available.
(require 'use-package)
(setq use-package-always-ensure t)


(message "Begin init...")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Personal settings

;; simple settings
(setq user-full-name "Michael Fagan"
      user-mail-address "michael.charles.fagan@gmail.com")


;; Specify the jupyter executable name, and the start dir of the server
(defvar my:jupyter_location (executable-find "jupyter"))
(defvar my:jupyter_start_dir "/home/mfagan/jupyter")


;; Backup/Autosave
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

(defvar backup-dir (concat "/home/" (user-login-name) "/.backup/"))
(setq backup-directory-alist (list (cons "." backup-dir)))


(setq vc-handled-backends nil)


;; emacs machine settings
(setq load-prefer-newer t)


;; disable startup message
(setq inhibit-startup-message t)

;; Opt out from the startup message in the echo area by simply disabling this
;; ridiculously bizarre thing entirely.
(fset 'display-startup-echo-area-message #'ignore)

;; Get rid of tool bar, menu bar and scroll bars.  On OS X we preserve the menu
;; bar, since the top menu bar is always visible anyway, and we'd just empty it
;; which is rather pointless.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (and (not (eq system-type 'darwin)) (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

;; short yes/no questions
(fset 'yes-or-no-p #'y-or-n-p)

;; clipboard mode
(setq x-select-enable-clipboard t
      x-select-enable-primary t)


;; transient mode
(setq-default transient-mark-mode t)


;; Frame movement (shift arrow)
(windmove-default-keybindings)
(setq windmove-wrap-around t )


;;; utf-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


(with-current-buffer "*scratch*"
	  (emacs-lock-mode 'kill))
(with-current-buffer "*Messages*"
	  (emacs-lock-mode 'kill))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visual settings

;; Theme
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(load-theme 'hipster t)

;;(set-face-attribute 'default t :font "Hack-Regular" )


;; Line mode
(global-linum-mode t)
(set-default 'truncate-lines t)


;; Indent setting
(setq-default tab-always-indent nil)

(defun my-generate-tab-stops (&optional width max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
         (tab-width (or width tab-width))
         (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))

(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq tab-stop-list (my-generate-tab-stops))

(set-variable 'python-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)

;;(electric-indent-mode 1)


;; highlight mode
(when window-system
  (global-hl-line-mode 1))


;; turn on highlight matching brackets when cursor is on one
(show-paren-mode t)


;; whitespace settings
(setq whitespace-line-column 100)

(setq whitespace-style
	  (quote (face trailing lines spaces tabs newline space-mark tab-mark newline-mark)))

;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
(setq whitespace-display-mappings
	  ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
	  '((space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
		(newline-mark 10 [182 10]) ; LINE FEED,
		(tab-mark 9 [9655 9] [92 9]) ; tab
		))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "gray5"))))
 '(whitespace-empty ((t (:foreground "red" :background "red"))))
 '(whitespace-indentation ((t (:foreground "yellow" :background "black"))))
 '(whitespace-line ((t (:foreground unspecified :underline "DarkRed"))))
 '(whitespace-newline ((t (:foreground "blue" :background "black"))))
 '(whitespace-space ((t (:foreground "gray25" :background "black"))))
 '(whitespace-space-after-tab ((t (:foreground "yellow" :background "black"))))
 '(whitespace-space-before-tab ((t (:foreground "red" :background "black"))))
 '(whitespace-tab ((t (:foreground "blue" :background "black"))))
 '(whitespace-trailing ((t (:bold t :foreground "red" :background "black")))))

(global-whitespace-mode 1)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions

(defun kill-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))


(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


(defun kill-unmodified-buffers ()
  "Kills all unmodified buffers and closes all but the selected frame."
  (interactive)
  (save-window-excursion
    (dolist (buffer (buffer-list))
      (and (buffer-live-p buffer)
           (not (buffer-modified-p buffer))
           (kill-buffer buffer)))))


(defun kill-orphan-buffers ()
  "Kills all buffers where the matching file doesn't exist."
  (interactive)
  (save-window-excursion
    (dolist (buffer (buffer-list))
      (and (buffer-live-p buffer)
           (not (buffer-modified-p buffer))
           (not (file-exists-p (buffer-file-name buffer)))
           (kill-buffer buffer)))))


(defun git-difftool (file-a file-b)
  (ediff-files file-a file-b))

(defun git-mergetool (file-a file-b file-out &optional file-ancestor)
  (if (and file-ancestor
           (file-exists-p file-ancestor)
           (file-readable-p file-ancestor))
      (ediff-merge-files-with-ancestor file-a file-b file-ancestor nil file-out)
    (ediff-merge-files file-a file-b nil file-out)))


(defun comment-or-uncomment-line ()
  "Comment or uncomment current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))

(defun indent-code-region (beginning end)
  "If there is an active region use indent-code-rigidly else indent-for-tab-command."
  (interactive "r")
  (if (use-region-p)
	  (indent-code-rigidly beginning end tab-width)
	(indent-for-tab-command)))


(defadvice indent-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))

(defadvice indent-code-rigidly (after deactivate-mark-nil activate)
     (if (called-interactively-p 'any)
         (setq deactivate-mark nil)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup keybindings

;; So you can't accidently quit or suspend the emacs server
(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-z"))

;; Stop uppercase-region warning from fucking with undo
(global-unset-key (kbd "C-x C-u"))


(global-set-key (kbd "<C-tab>") 'indent-code-region)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; q w e r t y u i o p [ ] \

;; M-` tmm-menubar
;; M-,
;; map for buffer (content) commands
;; flycheck-buffer
;; flycheck-next-error
;; flycheck-previous-error


;;; M-r  replace commands ;;;
(define-prefix-command 'replace-keymap)
(global-set-key (kbd "M-r") 'replace-keymap)

(global-set-key (kbd "M-r r") 'query-replace)
(global-set-key (kbd "M-r C-r") 'query-replace-regexp)
(global-set-key (kbd "M-r b") 'crux-rename-buffer-and-file)


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
;; M-p f        neotree
;; M-p TAB      helm-projectile-find-file


;;;;;;;;;;;;;;;;;;;;;;;;
;; a s d f g h j k l ; '

;;; M-s  search commands (extend) ;;;
(global-set-key (kbd "M-s s") 'isearch-forward)
(global-set-key (kbd "M-s C-s") 'isearch-forward-regexp)
(global-set-key (kbd "M-s r") 'isearch-backward)
(global-set-key (kbd "M-s C-r") 'isearch-backward-regexp)
;; M-s C-t      counsel-etags-grep-symbol-at-point
;; M-s t        counsel-etags-find-tag
;; M-s .        isearch-forward-symbol-at-point
;; M-s w        isearch-forward-word
;; M-s o        occur


;;; M-g  goto commands ;;;
(global-set-key (kbd "M-g 1") 'flycheck-first-error)
(global-set-key (kbd "M-g t") 'hl-todo-next)
(global-set-key (kbd "M-g C-t") 'hl-todo-previous)
;; M-g g        goto-line
;; M-g c        goto-char
;; M-g TAB      move-to-column
;; M-g n        next-error
;; M-g p        previous-error


;;; M-k  kill commands ;;;
(define-prefix-command 'kill-keymap)
(global-set-key (kbd "M-k") 'kill-keymap)

(global-set-key (kbd "M-k k") 'kill-buffer)
(global-set-key (kbd "M-k a") 'kill-all-buffers)
(global-set-key (kbd "M-k 1") 'kill-other-buffers)
(global-set-key (kbd "M-k u") 'kill-unmodified-buffers)
(global-set-key (kbd "M-k o") 'kill-orphan-buffers)
(global-set-key (kbd "M-k DEL") 'crux-delete-file-and-buffer)


;;; M-;  comment commands ;;;
(define-prefix-command 'comment-keymap)
(global-set-key (kbd "M-;") 'comment-keymap)

(global-set-key (kbd "M-; TAB") 'comment-dwim)
(global-set-key (kbd "M-; ;") 'comment-or-uncomment-line)
(global-set-key (kbd "M-; SPC") 'comment-or-uncomment-region)


;;;;;;;;;;;;;;;;;;;;;;
;; z x c v b n m , . /


;;; M-x  execute command -> counsel-M-x ;;;


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


;;; M-SPC  region commands ;;;
(define-prefix-command 'buffer-action-keymap)
(global-set-key (kbd "M-SPC") 'buffer-action-keymap)

(global-set-key (kbd "M-SPC 1") 'just-one-space)
(global-set-key (kbd "M-SPC SPC") 'set-mark-command)
(global-set-key (kbd "M-SPC w") 'kill-region)
(global-set-key (kbd "M-SPC M-w") 'kill-ring-save)
(global-set-key (kbd "M-SPC ;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-SPC TAB") 'my-indent-rigidly)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; install extra packages


(use-package revbufs
  :load-path contrib-load-path
  :config)

(use-package diminish
  :config
  (progn (add-hook 'whitespace-mode-hook (lambda () (diminish 'whitespace-mode)))))

(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  (ido-everywhere t)
  (ido-mode 1))

(use-package zeal-at-point)

(use-package json-mode)

(use-package pandoc-mode)

(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package markdown-mode
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config)

(use-package rst
  :config
  (add-hook 'rst-mode-hook
            (lambda ()
              (local-set-key (kbd "C-M-h") 'backward-kill-word)
              (setq-local fill-column 80)
              (turn-on-auto-fill))))

(use-package python
  :init
  (setq-default python-indent-offset 4))

(use-package blacken
  :config
  (setq blacken-line-length '100)
  (setq blacken-allow-py36 t)
  (add-hook 'python-mode-hook 'blacken-mode))

(use-package py-isort
  :init
  (setq py-isort-options '("--lines=100" "--multi-line=3"))
  (add-hook 'before-save-hook 'py-isort-before-save))

(use-package erlang
  :init
  :mode (("\\.erl\\'" . erlang-mode)
         ("\\.hrl\\'" . erlang-mode)
         ("\\.xrl\\'" . erlang-mode)
         ("sys\\.config\\'" . erlang-mode)
         ("rebar\\.config\\'" . erlang-mode)
         ("\\.app\\(\\.src\\)?\\'" . erlang-mode))
  :config
  (setq erlang-indent-level 4)
  (add-hook 'erlang-mode-hook
            (lambda ()
              (setq mode-name "erl"
                    erlang-compile-extra-opts '((i . "../include"))
                    erlang-root-dir "/usr/local/lib/erlang"))))

(use-package rainbow-delimiters
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function rainbow-delimiters-mode "rainbow-delimiters.el"))
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package beacon
  :init (beacon-mode 1)
  :diminish beacon-mode)

(use-package hl-todo
  :load-path contrib-load-path
  :config
  (global-hl-todo-mode))

(use-package electric
  :hook (prog-mode . electric-indent-mode))

(use-package google-this)

(use-package legalese)

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally))

(use-package magit
  :disabled t
  :bind (("C-x g" . magit-status)))

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

(use-package cython-mode
  :mode ("\\.pyd\\'" "\\.pyi\\'" "\\.pyx\\'"))

(use-package python-docstring
  :hook (python-mode . python-docstring-mode))

;;(use-package pydoc
;;  :after anaconda-mode
;;  :bind (:map anaconda-mode-map
;;			  ("M-?" . pydoc-at-point)))

(use-package pydoc)

(use-package pip-requirements
  :mode (("\\.pip\\'" . pip-requirements-mode)
         ("requirements.*\\.txt\\'" . pip-requirements-mode)
         ("requirements\\.in" . pip-requirements-mode)))

(use-package crux
  :bind (("C-c u" . crux-view-url)
         ("C-c f c" . write-file)
         ("C-c f r" . crux-rename-buffer-and-file)
         ("C-c f d" . crux-delete-file-and-buffer)
         ;;("s-k"   . crux-kill-whole-line)
         ;;("s-o"   . crux-smart-open-line-above)
         ("C-a"   . crux-move-beginning-of-line)
         ([(shift return)] . crux-smart-open-line)
         ([(control shift return)] . crux-smart-open-line-above)))

(use-package flycheck
  :config
  (setq-default flycheck-check-syntax-automatically '(save mode-enabled))
  :init
  (setq flycheck-python-pylint-executable "pylava-emacs-shim")
  (setq flycheck-pylintrc "pylava.ini")
  (setq flycheck-indication-mode 'left-fringe)
  (setq flycheck-highlighting-mode 'lines)
  (global-flycheck-mode))

;;(use-package flycheck-pyre)

(use-package neotree
  :bind ("M-p f" . neotree)
  :config
  (setq neo-dont-be-alone t
        neo-theme 'nerd)
  (bind-keys :map neotree-mode-map
             ("ESC" . neotree-hide)
             ("u" . neotree-select-up-node)
             ;;("d" . *-neo-down-and-next)
             ("i" . neotree-enter)
             ("K" . neotree-delete-node)))

(use-package projectile
  :init (projectile-global-mode)
  :bind ("s-p" . projectile-command-map)
  :config
  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-mode-line
    '(:eval (if (file-remote-p default-directory)
				" Prj[*remote*]"
			  (format " Prj[%s]" (projectile-project-name))))
	))

(use-package helm
  :diminish helm-mode
  :bind (("M-a" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ;("C-SPC" . helm-dabbrev)
         ("M-y" . helm-show-kill-ring)
         ("C-h i" . 'helm-info-at-point)
         ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
         ("M-i" . helm-previous-line)
         ("M-k" . helm-next-line)
         ("M-I" . helm-previous-page)
         ("M-K" . helm-next-page)
         ("M-h" . helm-beginning-of-buffer)
         ("M-H" . helm-end-of-buffer))
  :config (progn
         (setq helm-split-window-in-side-p           t
			   helm-move-to-line-cycle-in-source     t
			   helm-ff-search-library-in-sexp        t
			   helm-scroll-amount                    8
			   helm-ff-file-name-history-use-recentf t
			   helm-move-to-line-cycle-in-source     t
			   helm-prevent-escaping-from-minibuffer t
			   helm-bookmark-show-location           t)
		 (helm-mode 1)
		 (helm-adaptive-mode 1))
  )

(use-package helm-projectile
  :bind ("M-p TAB" . helm-projectile-find-file)
  :config
  (helm-projectile-on))

(use-package helm-pydoc
  :config
  (with-eval-after-load "python"
	(define-key python-mode-map (kbd "C-c C-d") 'helm-pydoc)))

(use-package helm-dash
  :init
  (global-set-key (kbd "M-. SPC") 'helm-dash-at-point)
  (defun c-doc ()
	(setq helm-dash-docsets '("C")))
  (defun c++-doc ()
	(setq helm-dash-docsets '("C" "C++")))
  (add-hook 'c-mode-hook 'c-doc)
  (add-hook 'c++-mode-hook 'c++-doc))

(use-package swiper-helm
  :bind ("C-s" . swiper-helm))

(use-package virtualenvwrapper
  ;; Automatically switch python venv
  :hook (projectile-after-switch-project . venv-projectile-auto-workon)
  :config
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell) ;; if you want eshell support
  (setq venv-location "/home/mfagan/.virtualenvs/"))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)
         ("<f1> l" . counsel-find-library)
         ("<f2> i" . counsel-info-lookup-symbol)
         ("<f2> u" . counsel-unicode-char)
         ("C-c g" . counsel-git-grep)
         ("C-c j" . counsel-git)
         ("C-c k" . counsel-ag)
         ("C-c r" . counsel-rg)
         ("C-x l" . counsel-locate)
         :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-add))
  :config
  (if (executable-find "rg")
      ;; use ripgrep instead of grep because it's way faster
      (setq counsel-grep-base-command
            "rg -i -M 120 --no-heading --line-number --color never '%s' %s"
            counsel-rg-base-command
            "rg -i -M 120 --no-heading --line-number --color never %s .")
      (warn "\nWARNING: Could not find the ripgrep executable. It "
            "is recommended you install ripgrep.")
  ))

;; Use universal ctags to build the tags database for the project.
;; When you first want to build a TAGS database run 'touch TAGS'
;; in the root directory of your project.
(use-package counsel-etags
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function counsel-etags-virtual-update-tags "counsel-etags.el")
    (declare-function counsel-etags-guess-program "counsel-etags.el")
    (declare-function counsel-etags-locate-tags-file "counsel-etags.el"))
  :bind (("M-. t" . counsel-etags-find-tag-at-point)
         ("M-s C-t" . counsel-etags-grep-symbol-at-point)
         ("M-s t" . counsel-etags-find-tag))
  :config
  ;; Ignore files above 800kb
  (setq counsel-etags-max-file-size 800)
  ;; Ignore build directories for tagging
  (add-to-list 'counsel-etags-ignore-directories '"build*")
  (add-to-list 'counsel-etags-ignore-directories '".vscode")
  (add-to-list 'counsel-etags-ignore-filenames '".clang-format")
  ;; Don't ask before rereading the TAGS files if they have changed
  (setq tags-revert-without-query t)
  ;; Don't warn when TAGS files are large
  (setq large-file-warning-threshold nil)
  ;; How many seconds to wait before rerunning tags for auto-update
  (setq counsel-etags-update-interval 180)
  ;; Set up auto-update
  (add-hook
   'prog-mode-hook
   (lambda () (add-hook 'after-save-hook
                        (lambda ()
                          (counsel-etags-virtual-update-tags))))
   )

  ;; The function provided by counsel-etags is broken (at least on Linux)
  ;; and doesn't correctly exclude directories, leading to an excessive
  ;; amount of incorrect tags. The issue seems to be that the trailing '/'
  ;; in e.g. '*dirname/*' causes 'find' to not correctly exclude all files
  ;; in that directory, only files in sub-directories of the dir set to be
  ;; ignore.
  (defun my-scan-dir (src-dir &optional force)
    "Create tags file from SRC-DIR. \
     If FORCE is t, the commmand is executed without \
     checking the timer."
    (let* ((find-pg (or
                     counsel-etags-find-program
                     (counsel-etags-guess-program "find")))
           (ctags-pg (or
                      counsel-etags-tags-program
                      (format "%s -e -L" (counsel-etags-guess-program
                                          "ctags"))))
           (default-directory src-dir)
           ;; run find&ctags to create TAGS
           (cmd (format
                 "%s . \\( %s \\) -prune -o -type f -not -size +%sk %s | %s -"
                 find-pg
                 (mapconcat
                  (lambda (p)
                    (format "-iwholename \"*%s*\"" p))
                  counsel-etags-ignore-directories " -or ")
                 counsel-etags-max-file-size
                 (mapconcat (lambda (n)
                              (format "-not -name \"%s\"" n))
                            counsel-etags-ignore-filenames " ")
                 ctags-pg))
           (tags-file (concat (file-name-as-directory src-dir) "TAGS"))
           (doit (or force (not (file-exists-p tags-file)))))
      ;; always update cli options
      (when doit
        (message "%s at %s" cmd default-directory)
        (shell-command cmd)
        (visit-tags-table tags-file t)
        )
      )
    )

  (setq counsel-etags-update-tags-backend
        (lambda ()
          (interactive)
          (let* ((tags-file (counsel-etags-locate-tags-file)))
            (when tags-file
              (my-scan-dir (file-name-directory tags-file) t)
              (run-hook-with-args
               'counsel-etags-after-update-tags-hook tags-file)
              (unless counsel-etags-quiet-when-updating-tags
                (message "%s is updated!" tags-file))))
          )
        )
  )

(use-package spaceline-config
  :ensure spaceline
  :config
  (spaceline-compile
   'lunaryorn
   ;; Left side of the mode line (all the important stuff)
   '(((buffer-modified buffer-size input-method) :face highlight-face)
     '(buffer-id remote-host buffer-encoding-abbrev)
     ((point-position line-column buffer-position selection-info)
      :separator " | ")
     major-mode
     process
     (flycheck-error flycheck-warning flycheck-info)
     (python-pyvenv :fallback python-pyenv)
     ((which-function projectile-root) :separator " @ ")
     ((minor-modes :separator spaceline-minor-modes-separator) :when active))
   ;; Right segment (the unimportant stuff)
   '((version-control :when active)))
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-lunaryorn)))
                header-line-format mode-line-format))

(use-package powerline
  :after spaceline-config
  :config)

;(use-package ein
;  :commands (ein:notebooklist-open))

;(use-package ein
;    :ensure t
;    :defer t
;    :config
;    (setq ein:jupyter-default-notebook-directory "~/Workspace/jupyter")
;    (setq ein:jupyter-default-server-command "~/anaconda3/bin/jupyter")
;    (setq ein:jupyter-server-args (list "--no-browser")))

;; ein - ipython notebooks in gui emacs
(if (and my:jupyter_location
         my:jupyter_start_dir)
    (use-package ein
      :disabled t
      :commands (ein:jupyter-server-start)
      :defer 5
      :config
      (require 'ein)
      (require 'ein-loaddefs)
      (require 'ein-notebook)
      (require 'ein-subpackages)
      ;; when editing the emacs.el file, we do not want to start a new
      ;; Jupyter server each time we save, so we only start a new Jupyter
      ;; server if there currently isn't one running.
      (defvar my-found-ein-server nil)
      (dolist (my-current-process (process-list))
        (when (string-match "EIN: Jupyter*" (process-name my-current-process))
          (setq my-found-ein-server t))
        )
      (when (not my-found-ein-server)
        (ein:jupyter-server-start my:jupyter_location my:jupyter_start_dir))
    )
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Server settings


(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Remove trailing white space upon saving
;; Note: because of a bug in EIN we only delete trailing whitespace
;; when not in EIN mode.
;(add-hook 'before-save-hook
;          (lambda ()
;            (when (not (derived-mode-p 'ein:notebook-multilang-mode))
;              (delete-trailing-whitespace))))


;; Check (on save) whether the file edited contains a shebang, if yes,
;; make it executable from
;; http://mbork.pl/2015-01-10_A_few_random_Emacs_tips
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Server mode

(when (display-graphic-p)
  (toggle-frame-maximized))


;; Start server (but don't restart).
(require 'server)
(unless (server-running-p)
  (server-start))

(setq scroll-error-top-bottom t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'server-visit-hook 'raise-frame)


(message "init.el loaded")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(hl-todo flycheck-pyre flycheck crux virtualenvwrapper blacken counsel-etags counsel swiper ivy rainbow-delimiters magit erlang pandoc-mode json-mode diminish use-package projectile flx-ido))))
