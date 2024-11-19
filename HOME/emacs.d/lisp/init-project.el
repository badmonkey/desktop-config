;;; init-project --- Configure project features
;;; Commentary:
;;; Code:


;; https://github.com/KaratasFurkan/.emacs.d#treemacs-1

(use-package projectile
  :diminish
  :init
  (projectile-global-mode)
  :custom
  (projectile-enable-caching nil)
  (projectile-indexing-method 'alien)
  :config
  (setq projectile-switch-project-action
    '(lambda ()
       (venv-projectile-auto-workon)
       (projectile-dired)))

  (projectile-register-project-type
    'buildsh '("build.sh")
    :compile "/bin/bash  build.sh build"
    :test "/bin/bash  build.sh test"
    :run "/bin/bash  build.sh run")
  (projectile-register-project-type
    'spm '("Package.swift")
    :compile "swift build"
    :test "swift test"
    :run "swift run")
  (projectile-register-project-type
    'pypi '("setup.py")
    :compile "pip build"
    :test "pip test"
    :run "pip run")
  )

(use-package projectile-ripgrep)

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
