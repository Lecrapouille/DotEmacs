(defun disable-global-hl-line-mode ()
  (setq global-hl-line-mode nil)
  (make-local-variable 'global-hl-line-mode))

(add-hook 'term-mode-hook 'disable-global-hl-line-mode)
