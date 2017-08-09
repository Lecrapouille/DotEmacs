(defun cleanup-dwim ()
  (interactive)
  (if (evil-visual-state-p)
      (let ((begin evil-visual-beginning)
            (end evil-visual-end))
        (indent-region begin end)
        (whitespace-cleanup-region begin end))
    (error "Please select a region")))

;; Fonction remplaçant toutes les tabulations du tampon courant par le
;; nombre d'espaces qui ne modifie pas la mise en page apparente
;; (étrangement, la fonction native d'Emacs ne s'applique qu'à une
;; région, pas à un tampon entier).

(defun untabify-buffer ()
  "Untabify the entire buffer."
  (interactive)
  (untabify (point-min) (point-max))
  )

(defun untabify-except-makefiles ()
  "Replace tabs with spaces except in makefiles."
  (unless (derived-mode-p 'makefile-mode)
    (untabify (point-min) (point-max))))

(defun remove-ctrlM ()
  "Cut all visible ^M."
  (interactive)
  (beginning-of-buffer)
  (while (search-forward "\r" nil t)
    (replace-match "" nil t))
  )

;; Lorsque le fichier est sauvegardé, demander s'il faut ajouter un
;; saut de ligne final lorsqu'il est absent et effacer les espaces
;; superflus en fin de ligne.
(setq require-final-newline 'query)
(add-hook 'write-file-hooks '(lambda () (delete-trailing-whitespace)))
;; (add-hook 'before-save-hook '(lambda () (untabify-buffer)))
(add-hook 'before-save-hook '(lambda () (untabify-except-makefiles)))

(setq show-trailing-whitespace t)
(setq-default show-leading-whitespace t)
(setq-default indicate-empty-lines t)
(defface extra-whitespace-face
  '((t (:background "pale green")))
  "Used for tabs and such.")
(defvar my-extra-keywords
  '(("\t" . 'extra-whitespace-face)))
