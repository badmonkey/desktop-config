;;; init-ctrlchords --- Add ctrl-chord bindings
;;; Commentary:
;;; Code:



(general-unbind
;; So you can't accidently quit or suspend the emacs server
  "C-x C-c"
  "C-z"

;; Stop uppercase-region warning from fucking with undo
  "C-x C-u")



;; (global-set-key (kbd "C-x u") 'undo-tree-visualize)

;; TAB SPC ! $ % & ' ( ) , - . / : ; < = > ? @ \ ^ `
;; abcdefghijklmnopqrstuvwxyz
;; { | } ~ DEL


(general-define-key
  "C-=" 'er/expand-region

  "<C-return>"    'crux-smart-open-line
  "<S-return>"    'crux-smart-open-line-above
  "<C-backspace>" 'region-kill-to-left-margin
  "<C-tab>"       'region-indent-code


  "C-a"           'crux-move-beginning-of-line

  "C-k"           'region-kill-line
  "C-w"           'region-copy-whole-line

  "C-s"           'swiper-helm)


;; C-c


(general-define-key
  :prefix "C-x"

  "C-b"           'ibuffer
  "<left>"        'switch-to-last-buffer)


(provide 'init-ctrlchords)
;;; init-ctrlchords.el ends here
