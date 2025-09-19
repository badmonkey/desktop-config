;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-highlight --- Configure highlighting


(use-package highlight-indent-guides
  :config
  ;; (set-face-background 'highlight-indent-guides-odd-face "darkgray")
  ;; (set-face-background 'highlight-indent-guides-even-face "darkred")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-top-character-face "darkred")
  (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-method 'bitmap)
  (setq highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-dots)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package hl-todo
  :config

  (add-list-to-list 'hl-todo-keyword-faces
    '(("\\(\\w+ign\\)"      . "darkred")
       ("teh"               . "darkred")
       ("fro"               . "darkred")
       ("jsut"              . "darkred")
       ("\\(\\w*casue\\)"   . "darkred")))

  (global-hl-todo-mode))

(use-package beacon
  :if (startup? 'with-heavy-visuals)
  :init
  ;; (setq beacon-size  7
  ;;       beacon-color "#f85e9f")
  ;; (beacon-color "#f1fa8c")
  (beacon-mode 1)
  :diminish beacon-mode)


;; highlight mode
(when (display-graphic-p)
  (global-hl-line-mode 1))


(provide 'init-bundle-highlight)
;;; init-bundle-highlight.el ends here
