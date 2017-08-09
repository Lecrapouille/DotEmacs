(setq-default abbrev-mode t)
(read-abbrev-file "~/.emacs.d/abbrevs")
;; (setq save-abbrevs t)

(defun no-self-insert-hook ()
  "Abbrev hook function, used for `define-abbrev'.
 Our use is to prevent inserting the char that triggered expansion."
  t)

(put 'no-self-insert-hook 'no-self-insert t)

(define-abbrev-table 'global-abbrev-table '(("ć" "ç" no-self-insert-hook)))
