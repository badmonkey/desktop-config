;;; -*- lexical-binding: t; -*-
;;;
;;; init-lang-elisp --- Configure lang elisp


(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (setq mode-name "λ")
    (setq indent-tabs-mode nil)))


(provide 'init-lang-elisp)
;;; init-lang-elisp.el ends here
