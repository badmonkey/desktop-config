;;; init-ctrlchords --- Add ctrl-chord bindings
;;; Commentary:
;;; Code:


;; So you can't accidently quit or suspend the emacs server
(global-unset-key (kbd "C-x C-c"))
(global-unset-key (kbd "C-z"))

;; Stop uppercase-region warning from fucking with undo
(global-unset-key (kbd "C-x C-u"))



;; TAB SPC ! $ % & ' ( ) , - . / : ; < = > ? @ \ ^ `
;; abcdefghijklmnopqrstuvwxyz
;; { | } ~ DEL


(global-set-key (kbd "C-DEL") 'region-kill-to-left-margin)
(global-set-key (kbd "C-TAB") 'region-indent-code)


(global-set-key (kbd "C-k") 'region-kill-line)
(global-set-key (kbd "C-w") 'region-copy-whole-line)


(global-set-key (kbd "C-x C-b") 'ibuffer)


(provide 'init-ctrlchords)
;;; init-ctrlchords.el ends here
