;;; -*- lexical-binding: t; -*-
;;;
;;; init-helm --- Configure helm

;; https://github.com/KaratasFurkan/.emacs.d#helm
;; https://github.com/KaratasFurkan/.emacs.d#helm-projectile

(use-package helm
  :diminish helm-mode
  :config
  (setq
    helm-split-window-in-side-p           t
    helm-move-to-line-cycle-in-source     t
    helm-ff-search-library-in-sexp        t
    helm-scroll-amount                    8
    helm-ff-file-name-history-use-recentf t
    helm-move-to-line-cycle-in-source     t
    helm-prevent-escaping-from-minibuffer t
    helm-bookmark-show-location           t
    helm-buffer-max-length               64)
  (helm-mode 1)
  (helm-adaptive-mode 1)
  (setq helm-boring-buffer-regexp-list
    (append hidden-buffer-regexp-list transient-buffer-regexp-list)))

(use-package helm-posframe
  :after helm
  :custom-face
  (helm-posframe-border ((t (:background "#b58900"))))
  :custom
  (helm-display-header-line nil)
  (helm-echo-input-in-header-line t)
  (helm-posframe-border-width 3)
  (helm-posframe-parameters '((left-fringe . 10)
                               (right-fringe . 10)))
  (helm-posframe-size-function 'fk/helm-posframe-get-size)
  :config
  (setq helm-posframe-poshandler 'posframe-poshandler-frame-center
    helm-posframe-height (frame-height)
    helm-posframe-width (frame-width))

  (helm-posframe-enable)

  (remove-hook 'delete-frame-functions 'helm--delete-frame-function)

  ;; Fix helm-posframe-display: Wrong type argument: window-live-p, #<window XYZ>
  (defun fk/helm-posframe-disable-on-minibuffer (orig-func &rest args)
    "Disable `helm-posframe' if it is called from minibuffer."
    (let ((helm-display-function 'helm-default-display-buffer))
      (apply orig-func args)))

  (advice-add 'helm-read-pattern-maybe :around 'fk/helm-posframe-disable-on-minibuffer)

  (defun fk/helm-posframe-get-size ()
    (list
      :min-width (round (* (frame-width) 0.75))
      :min-height (round (* (frame-height) 0.5)))))

(use-package helm-projectile
  :custom
  (helm-projectile-sources-list '(helm-source-projectile-buffers-list
                                   helm-source-projectile-recentf-list
                                   helm-source-projectile-files-list
                                   helm-source-projectile-projects))
  :init
  :config
  (setq projectile-completion-system 'helm)
  (setq helm-projectile-fuzzy-match nil)
  (helm-projectile-on))

(use-package helm-pydoc
  :config)

(use-package helm-google)

(use-package helm-bm)

(use-package helm-xref)

;; (use-package helm-unicode)

(use-package helm-dash
  :init
  (defun c-doc ()
    (setq helm-dash-docsets '("C")))
  (defun c++-doc ()
    (setq helm-dash-docsets '("C" "C++")))
  (add-hook 'c-mode-hook 'c-doc)
  (add-hook 'c++-mode-hook 'c++-doc))

(use-package swiper-helm)

(use-package ac-helm)

(use-package helm-rg)

(use-package ggtags)

(use-package imenu-anywhere)

(use-package dogears
  :config
  (dogears-mode))

(use-package helm-dogears
  :after dogears)


(provide 'init-helm)
;;; init-helm.el ends here
