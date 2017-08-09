(defun lisp-style ()
  (setq indent-tabs-mode nil)
  (whitespace-mode))

(setq lisp-hooks '(lisp-interaction-mode-hook ; *scratch* buffer
                   emacs-lisp-mode-hook
                   scheme-mode-hook))

(setq repl-hooks '(eval-expression-minibuffer-setup-hook
                   geiser-repl-mode-hook))

(defun remove-hooks (hook-list function)
  (while hook-list
    (remove-hook (car hook-list) function)
    (setq hook-list (cdr hook-list))))

(defun add-hooks (hook-list function)
  (while hook-list
    (add-hook (car hook-list) function)
    (setq hook-list (cdr hook-list))))

(add-hooks lisp-hooks #'enable-paredit-mode)
(add-hooks lisp-hooks #'rainbow-delimiters-mode)
(add-hooks lisp-hooks #'lisp-style)

(add-hooks repl-hooks #'enable-paredit-mode)
(add-hooks repl-hooks #'rainbow-delimiters-mode)

(add-hook 'scheme-mode-hook 'guix-devel-mode)
