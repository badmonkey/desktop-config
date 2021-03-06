;;; init-spaceline --- Config spaceline
;;; Commentary:
;;; Code:

;; https://github.com/dbordak/telephone-line
;; https://github.com/dbordak/telephone-line/blob/110c578ccf6c0421cfd9eec7aa3e960b6fd49fb4/examples.org
;; https://github.com/MagicDuck/emacs-config/blob/master/init.el
;; https://quinoa42.github.io/en/dot-emacs/


(use-package spaceline
  :config

  (spaceline-define-segment python-venvwrap
    "The current python venv, if different from project-name"
    (when (and active
               (eq major-mode 'python-mode)
               (bound-and-true-p venv-current-name))
      (let ((tmp-venv-name (venv-display-name)))
        (if (string= (projectile-project-name) tmp-venv-name)
          "//PROJECT//"
          (propertize (format "//%s//" tmp-venv-name)
                      'face 'spaceline-python-venv
                      'help-echo (format "Virtual environment: %s" tmp-venv-name))))))

  (spaceline-define-segment projectile-segment
    "Show the current projectile root."
    (when (fboundp 'projectile-project-name)
      (let ((project-name (projectile-project-name)))
        (unless (or (string= project-name "-")
                    (string= project-name (buffer-name)))
          (format "%s|%s" project-name (projectile-project-type))))))
  )


(use-package spaceline-config
  :straight (spaceline :host github :repo "TheBB/spaceline")
  :config
  (setq spaceline-workspace-numbers-unicode t)
  (spaceline-toggle-minor-modes-off)
  (spaceline-helm-mode 1)
  (spaceline-compile
    'lunaryorn
    ;; Left side of the mode line (all the important stuff)
    '(((buffer-modified buffer-size input-method) :face highlight-face)
      '(buffer-id)
      ;; '(buffer-id buffer-encoding-abbrev)
      ((point-position line-column buffer-position selection-info) :separator " | ")
      major-mode
      process
      (("!?" flycheck-error flycheck-warning flycheck-info) :when flycheck-current-errors)
      (python-venvwrap :fallback python-pyvenv)
      projectile-segment
      ((minor-modes :separator spaceline-minor-modes-separator) :when active))
    ;; Right segment (the unimportant stuff)
    '((version-control :when active)))
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-lunaryorn)))
                header-line-format mode-line-format))


;; (use-package eyeliner
;;   :straight (eyeliner :type git :host github :repo "dustinlacewell/eyeliner")
;;   :config
;;   (require 'eyeliner)
;;   (eyeliner/install))

;; (eyeliner/style 'buffer-name eyeliner/plain-color)
;; (eyeliner/style 'buffer-name-modified eyeliner/warm-color)

;; (eyeliner/segment eyeliner/buffer-name
;;   (let* ((buffer-state (format-mode-line "%*"))
;;          (style (cond
;;                  ((string= buffer-state "-") 'eyeliner/buffer-name-style)
;;                  ((string= buffer-state "*") 'eyeliner/buffer-name-modified-style)
;;                  ((string= buffer-state "%") 'eyeliner/buffer-name-modified-style))))
;;     (apply style `(,(buffer-name)))))

;; (eyeliner/icon unmodified "circle-o" eyeliner/cool-color)
;; (eyeliner/icon modified "dot-circle-o" eyeliner/warm-color)
;; (eyeliner/icon locked "diff-added" eyeliner/warm-color)

;; (eyeliner/segment eyeliner/buffer-modified
;;   (let ((buffer-state (format-mode-line "%*")))
;;     (cond
;;      ((string= buffer-state "-") (eyeliner/unmodified-icon))
;;      ((string= buffer-state "*") (eyeliner/modified-icon))
;;      ((string= buffer-state "%") (eyeliner/locked-icon)))))


(diminish
  (list 'indent-guide-mode 'subword-mode))



(provide 'init-powerline)
;;; init-powerline.el ends here
