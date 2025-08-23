;;; ...  -*- lexical-binding: t -*-
;;;
;;; init-server --- Server settings

;; Remove trailing white space upon saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Check (on save) whether the file edited contains a shebang, if yes,
;; make it executable
;; http://mbork.pl/2015-01-10_A_few_random_Emacs_tips
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)

;; Start server (but don't restart an existing server)
(add-hook 'after-init-hook
          (lambda ()
            (message "Running server")
            (require 'server)
            (unless (server-running-p)
              (server-start))))

(setq scroll-error-top-bottom t)

(when (display-graphic-p)
  (message "Graphical display")
  (unless (eq (shape/display) 'display-shape-portrait)
    (add-to-list 'initial-frame-alist '(fullscreen . maximized))
    (add-to-list 'default-frame-alist '(fullscreen . maximized)))
  (add-hook 'server-visit-hook 'raise-frame)
  (add-hook 'after-init-hook
            (lambda ()
              (cl-case (shape/frame)
                (frame-shape-landscape (split-window-right))
                (frame-shape-portrait (split-window-below))
                (frame-shape-square nil))))
  )



(provide 'init-server)
;;; init-server.el ends here
