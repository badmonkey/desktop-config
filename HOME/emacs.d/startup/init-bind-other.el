;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-misc --- Add general bindings


(general-define-key
  :prefix "ESC"
  "ESC" 'keyboard-quit
  )


(general-define-key
  "<f5>"            'projectile-compile-project
  "<backtab>"       'region-indent-left

  "<home>"          'crux-move-beginning-of-line
  "<end>"           'move-end-of-line

  "<backspace>"     'delete-char-kill-region
  )

;; :bind (("M-x" . counsel-M-x)
;;         ("C-x C-f" . counsel-find-file)
;;         ("<f1> f" . counsel-describe-function)
;;         ("<f1> v" . counsel-describe-variable)
;;         ("<f1> l" . counsel-find-library)
;;         ("<f2> i" . counsel-info-lookup-symbol)
;;         ("<f2> u" . counsel-unicode-char)
;;         ("C-c g" . counsel-git-grep)
;;         ("C-c j" . counsel-git)
;;         ("C-c k" . counsel-ag)
;;         ("C-c r" . counsel-rg)
;;         ("C-x l" . counsel-locate)
;;         :map minibuffer-local-map
;;         ("C-r" . counsel-minibuffer-add))

;; :bind (("M-. t" . counsel-etags-find-tag-at-point)
;;         ("M-s C-t" . counsel-etags-grep-symbol-at-point)
;;         ("M-s t" . counsel-etags-find-tag))


(provide 'init-bind-misc)
;;; init-bind-misc.el ends here
