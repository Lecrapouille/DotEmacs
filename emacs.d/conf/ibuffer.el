;;; reloading: either kill *Ibuffer* or M-x ibuffer, / R "default"

(setq ibuffer-saved-filter-groups
      (quote (("default"

               ;; shells (has to be first because of name conflicts)
               ("shell" (or (mode . shell-mode)
                            (mode . eshell-mode)
                            (mode . term-mode)))

               ("org" (mode . org-mode))
               ("erc" (mode . erc-mode))

               ;; emacs standard buffers
               ("emacs" (name . "^\\*"))

               ))))

;; Enable default groups by default
(add-hook 'ibuffer-mode-hook
              (lambda ()
                (ibuffer-switch-to-saved-filter-groups "default")))

;; You probably don't want to see empty project groups
(setq ibuffer-show-empty-filter-groups nil)
