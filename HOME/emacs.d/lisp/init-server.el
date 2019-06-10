;;; init-server --- Server settings
;;; Commentary:
;;; Code:


;; Remove trailing white space upon saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Check (on save) whether the file edited contains a shebang, if yes,
;; make it executable
;; http://mbork.pl/2015-01-10_A_few_random_Emacs_tips
(add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p)


;; (when (display-graphic-p)
;;   (toggle-frame-maximized))


;; Start server (but don't restart).
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))


(setq scroll-error-top-bottom t)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'server-visit-hook 'raise-frame)

(split-window-right)


(provide 'init-server)
;;; init-server.el ends here
