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

  ; false positives: -sign, align, arraign, benign, campaign, deign, feign, malign, reign
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


;; XXX
;; XXX explain text
;; XXX: explain text
;; XXX: W0713
;; XXX: W0713:
;; XXX: W0713, E1000: more text
;; XXX(person): explain text
;; XXX(person): W0713, E1000: more text
;; XXX(person@where): WW000: more@text


;; (defcustom hl-todo-keyword-faces
;;   '(("HOLD"     . "#d0bf8f")
;;     ("WIP"      . "#d0bf8f")
;;     ("TODO"     . "#cc9393")
;;     ("NEXT"     . "#dca3a3")
;;     ("BUG"      . "#dca3a3")
;;     ("BUGFIX"   . "#dca3a3")
;;     ("THEM"     . "#dc8cc3")
;;     ("PROG"     . "#7cb8bb")
;;     ("OKAY"     . "#7cb8bb")
;;     ("DONT"     . "#5f7f5f")
;;     ("DONTFIX"  . "#5f7f5f")
;;     ("NOFIX"    . "#5f7f5f")
;;     ("NOQA"     . "#5f7f5f")
;;     ("noqa"     . "#5f7f5f")
;;     ("FAIL"     . "#8c5353")
;;     ("DONE"     . "#afd8af")
;;     ("SEE"      . "#afd8af")
;;     ("REF"      . "#afd8af")
;;     ("NOTE"     . "#d0bf8f")
;;     ("EXPLAIN"  . "#d0bf8f")
;;     ("KLUDGE"   . "#d0bf8f")
;;     ("HACK"     . "#d0bf8f")
;;     ("TEMP"     . "#d0bf8f")
;;     ("FIXME"    . "#cc9393")
;;     ("FIX"      . "#cc9393")
;;     ("XXX"      . "#cc9393")
;;     ("XXXX"     . "#cc9393")
;;     ("???"      . "#cc9393")
;;     ("!!!"      . "#cc9393"))

(provide 'init-bundle-highlight)
;;; init-bundle-highlight.el ends here
