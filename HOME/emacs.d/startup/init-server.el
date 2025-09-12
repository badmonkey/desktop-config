;;; -*- lexical-binding: t; -*-
;;;
;;; init-server --- Server settings


;; Start server (but don't restart an existing server)
(add-hook 'after-init-hook
  (lambda ()
    (message "Starting server...")
    (require 'server)
    (unless (server-running-p)
      (server-start))))

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
