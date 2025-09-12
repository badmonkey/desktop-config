;;; -*- lexical-binding: t; -*-
;;;
;;; init-lang-lua --- Configure lang lua


(use-package lua-mode
  :mode (("\\.lua\\'" . lua-mode))
  :config
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil)
  (setq lua-indent-level 2)
  )


(provide 'init-lang-lua)
;;; init-lang-lua.el ends here
