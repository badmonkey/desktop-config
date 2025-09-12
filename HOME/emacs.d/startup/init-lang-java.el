;;; -*- lexical-binding: t; -*-
;;;
;;; init-lang-java --- Configure lang java


;;(use-package google-java-format
;;  :if (startup? 'with-java)
;;  :straight (google-java-format
;;              :type nil
;;              :local-repo (expand-file-name "google-java-format" user-sitelisp-directory))
;;  :config
;;  (add-hook 'java-mode-hook
;;    (lambda ()
;;      (setq c-basic-offset 4
;;        tab-width 4
;;        indent-tabs-mode t)
;;      (add-hook 'before-save-hook 'google-java-format-buffer nil 'local))))


(provide 'init-lang-java)
;;; init-lang-java.el ends here
