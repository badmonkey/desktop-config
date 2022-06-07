;;; init-project --- Configure project features
;;; Commentary:
;;; Code:


;; https://github.com/KaratasFurkan/.emacs.d#treemacs-1

(use-package projectile
  :diminish
  :init
  (projectile-global-mode)
  :custom
  (projectile-enable-caching t)
  (projectile-indexing-method 'alien)
  :config
  (setq projectile-switch-project-action
        '(lambda ()
           (venv-projectile-auto-workon)
           (projectile-dired)))
  (projectile-register-project-type
    'adhocsh '(".adhoc.sh")
    :compile "/bin/bash  .adhoc.sh build "
    :test "/bin/bash  .adhoc.sh test "
    :run "/bin/bash  .adhoc.sh run "))
;; (add-to-list 'projectile-project-root-files ".projectile"))


(use-package projectile-ripgrep)


(use-package dashboard
  :config
  ;; (use-package dashboard-project-status
  ;;   :config
  ;;   (add-to-list 'dashboard-item-generators
  ;;                `(project-status . ,(dashboard-project-status "/opt/projects/owlbear")))
  ;;   (add-to-list 'dashboard-items '(project-status) t))
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.emacs.d/logo.png")
  (setq dashboard-banner-logo-title "Kill all humans")
  (setq dashboard-set-init-info nil)
  ;; (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-footer nil)
  ;; (setq dashboard-footer (shell-command-to-string "fortune -s"))
  (setq dashboard-items '((recents   . 10)
                          ;; (projects  . 5)
                          ;; (project-status . 10)
                          (bookmarks . 10))))


(add-hook 'emacs-startup-hook
          '(lambda ()
             (switch-to-buffer dashboard-buffer-name)
             (emacs-lock-mode 'kill)))


;; (require 'subr-x)
;; (dolist (package (sort (hash-table-keys straight--recipe-cache)
;;                        #'string-lessp))
;;   (insert (format
;;            "%25s | %s\n"
;;            package (plist-get (gethash package straight--recipe-cache)
;;                               :local-repo))))


(provide 'init-project)
;;; init-project.el ends here
