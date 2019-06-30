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



(provide 'init-lang)
;;; init-lang.el ends here
