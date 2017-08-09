(defun sh-style ()
  (whitespace-mode))

(add-hook 'sh-mode-hook #'sh-style)

;; Emacs shell

(setq explicit-shell-file-name "/bin/bash")
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq shell-prompt-pattern "> ")
(global-font-lock-mode 1)
