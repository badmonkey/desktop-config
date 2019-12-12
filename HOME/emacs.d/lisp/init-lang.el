;;; init-lang --- Configure lang modes - lua, erlang
;;; Commentary:
;;; Code:



(use-package lua-mode
  :mode (("\\.lua\\'" . lua-mode))
  :config
  (setq lua-indent-level 4))


(use-package erlang

  :init
  :mode (("\\.erl\\'" . erlang-mode)
         ("\\.hrl\\'" . erlang-mode)
         ("\\.xrl\\'" . erlang-mode)
         ("sys\\.config\\'" . erlang-mode)
         ("rebar\\.config\\'" . erlang-mode)
         ("\\.app\\(\\.src\\)?\\'" . erlang-mode))
  :config
  (setq erlang-indent-level 4)
  (add-hook 'erlang-mode-hook
            (lambda ()
              (setq mode-name "erl" erlang-compile-extra-opts '((i . "../include"))
                    erlang-root-dir "/usr/local/lib/erlang"))))


(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq mode-name "λ")
            (setq indent-tabs-mode nil)))


(use-package ponylang-mode
  :ensure t
  :config
  (progn
    (add-hook
     'ponylang-mode-hook
     (lambda ()
       (set-variable 'indent-tabs-mode nil)
       (set-variable 'tab-width 4)))))



(provide 'init-lang)
;;; init-lang.el ends here
