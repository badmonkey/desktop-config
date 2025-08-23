;;; ...  -*- lexical-binding: t -*-
;;;
;;; init-project --- Configure project features

;; https://github.com/KaratasFurkan/.emacs.d#treemacs-1

(defvar projectile-working-project-root nil)

;; (defun set-main-project (&optional dir)
;;   "Set the projectile main project based on the current buffer.
;; When called with argument DIR, make that main project instead."
;;   (interactive)
;;   (if dir
;;     (setq projectile-main-project dir)
;;     (let ((current-project))
;;       (let ((projectile-main-project nil))
;;         (setq current-project (projectile-project-root)))
;;       (setq projectile-main-project current-project))))

;; (defun use-main-project (&rest args)
;;   "Skip calling `projectile-project-root' when there is a main project defined."
;;   (when projectile-main-project
;;     projectile-main-project))

;; (advice-add #'projectile-project-root :before-until #'use-main-project)


(use-package projectile
  :after dirvish
  :diminish
  :init
  (projectile-global-mode)
  :custom
  (projectile-enable-caching t)
  (projectile-indexing-method 'alien)
  (projectile-sort-order 'recently-active)
  :config
  (setq projectile-switch-project-action
    '(lambda ()
       (venv-projectile-auto-workon)
       (projectile-dired)))

  (projectile-register-project-type 'buildsh '("build.sh")
    :project-file "build.sh"
    :configure "build.sh config"
    :compile "build.sh build"
    :test "build.sh test"
    :run "build.sh run")
  (projectile-register-project-type 'spm '("Package.swift")
    :project-file "Package.swift"
    :compile "swift build"
    :test "swift test"
    :run "swift run")
  (projectile-register-project-type 'pypi '("setup.py")
    :project-file "setup.py"
    :compile "pip build"
    :test "pip test"
    :run "pip run")
  )

(use-package projectile-ripgrep
  :after projectile)

(use-package neotree
  :after all-the-icons
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))


(use-package dashboard
  :config
  ;; (use-package dashboard-project-status
  ;;   :config
  ;;   (add-to-list 'dashboard-item-generators
  ;;                `(project-status . ,(dashboard-project-status "/opt/projects/owlbear")))
  ;;   (add-to-list 'dashboard-items '(project-status) t))
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner (expand-file-name "logo.png" user-emacs-directory))
  (setq dashboard-banner-logo-title "/A/lways /B/e /C/oding")
  (setq dashboard-set-init-info nil)
  ;; (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-footer nil)
  (setq dashboard-set-navigator t)
  ;; (setq dashboard-footer (shell-command-to-string "fortune -s"))
  (setq dashboard-items '((recents   . 10)
                           ;; (projects  . 5)
                           ;; (project-status . 10)
                           (bookmarks . 10))))


(add-hook 'emacs-startup-hook
          #'(lambda ()
              (switch-to-buffer dashboard-buffer-name)
              (emacs-lock-mode 'kill)))


;; https://protesilaos.com/emacs/denote
;; (use-package denote)
;;   :config
;;   (setq denote-directory (expand-file-name "~/notes/"))
;;   (setq denote-known-keywords '("emacs" "code" "ideas"))
;;   (setq denote-infer-keywords t)
;;   (setq denote-sort-keywords t)
;;   (setq denote-file-type 'text)
;;   (setq denote-prompts '(title keywords))
;;   (setq denote-allow-multi-word-keywords t)
;;   (setq denote-date-format "%d/%m/%y")
;;   (setq denote-link-fontify-backlinks t)
;;   )

;; (add-hook 'find-file-hook #'denote-link-buttonize-buffer)


;; (require 'subr-x)
;; (dolist (package (sort (hash-table-keys straight--recipe-cache)
;;                        #'string-lessp))
;;   (insert (format
;;            "%25s | %s\n"
;;            package (plist-get (gethash package straight--recipe-cache)
;;                               :local-repo))))


(provide 'init-project)
;;; init-project.el ends here
