(defun cursors-quit ()
  (evil-mc-undo-all-cursors)
  (turn-off-evil-mc-mode))

(defun cursors-get-scope ()
  "Get cursors' scope depending of whether there is a region or not.
If there is no region, the scope is the function"
  (let (begin end)
    (if (not (evil-visual-state-p))
        (save-excursion
          (beginning-of-defun)
          (setq begin (point))
          (end-of-defun)
          (setq end (point)))
      (evil-exit-visual-state)
      (setq begin evil-visual-beginning)
      (setq end evil-visual-end))
    (cl-values begin end)))

(defun make-cursors-column ()
  "Make cursors in column if there is only one of them.
Remove them all otherwise."
  (interactive)
  (if (bound-and-true-p evil-mc-cursor-list) (cursors-quit)
    (cl-multiple-value-bind (begin end) (cursors-get-scope)
      (turn-on-evil-mc-mode)
      (save-restriction
        (narrow-to-region begin end)
        (let ((col (current-column)))
          (goto-char (point-max))
          (while (not (= (line-number-at-pos) 2))
            (forward-line -1)
            (move-to-column col)
            (evil-mc-make-cursor-here))
          (forward-line -1)
          (move-to-column col))))))

(defun make-cursors-search-ring ()
  "Make cursors matching search-ring if there is only one of them.
Remove them all otherwise."
  (interactive)
  (if (bound-and-true-p evil-mc-cursor-list) (cursors-quit)
    (cl-multiple-value-bind (begin end) (cursors-get-scope)
      (turn-on-evil-mc-mode)
      (save-restriction
        (narrow-to-region begin end)
        (goto-char (point-max))
        (let ((regexp (if evil-regexp-search
                          (car-safe regexp-search-ring)
                        (car-safe search-ring))))
          (re-search-backward regexp nil t)
          (let ((old-point (point))
                (count 100))
            (while (and (re-search-backward regexp nil t)
                        (> count 0))
              (save-excursion
                (goto-char old-point)
                (evil-mc-make-cursor-here))
              (setq old-point (point))
              (setq count (- count 1)))))))))
