;;; init-helm --- Configure helm
;;; Commentary:
;;; Code:


;; (use-package ido
;;   :config
;;   (setq ido-enable-flex-matching t)
;;   (ido-everywhere t)
;;   (ido-mode 1))


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

(use-package helm-posframe
  :after helm
  :config
  (helm-posframe-enable)
  (setq helm-posframe-parameters
        '((left-fringe . 10)
          (right-fringe . 10))))

(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package helm-pydoc
  :config)

(use-package helm-google)

(use-package helm-bm)

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


(provide 'init-helm)
;;; init-helm.el ends here
