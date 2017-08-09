(defun format-bt (beg end)
  (defun path-to-link (beg end)
    "Transform a path into a link"
    (save-excursion
      (goto-char beg)
      (re-search-forward (rx (any blank "\n" ")")) nil 1)
      (let* ((end (1- (point))) ;; ignore region
             (ins "file://~/"))
        (goto-char beg)
        (insert ins)
        (search-forward ":" nil 1)
        (insert ":"))))
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (let ((end-marker (copy-marker end)))
      (while (<= (point) end-marker)
        (search-forward "at ")
        (path-to-link (point) nil)
        (re-search-forward (rx (any blank "\n" ")")) nil 1)))))

(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(defun kernel-style ()
  (setq indent-tabs-mode t)
  (whitespace-mode)
  (c-set-style "linux-tabs-only"))

(defun google-style ()
  (setq indent-tabs-mode nil)
  (whitespace-mode)
  (google-set-c-style)
  (setq c-basic-offset 4))

(defun renesas-style ()
  (setq indent-tabs-mode t)
  (setq tab-width 4)
  (whitespace-mode)
  (c-set-style "linux-tabs-only"))

(defun lecrapouille-style()
  (setq c-indent-level 4)
  (setq c-continued-statement-offset 4)
  (setq c-brace-offset 4)
  (setq c-argdecd-indent 4)
  (setq c-label-offset -4)
  (c-set-style "gnu"))

(defun match-in-list (file file-list)
  (if (null file-list)
      nil
    (or (string-match (regexp-quote (car file-list)) file)
        (match-in-list file (cdr file-list)))))

(defun match-path (path)
  (string-match (expand-file-name path) filename))

(defun find-code-style ()
  (when (buffer-file-name)
    (let ((filename (file-truename (buffer-file-name))))
      (cond

       ((match-in-list filename parrot-old-style-list)
        (parrot-old-style))

 ;; Define your project
 ;;      ((match-path "~/home/john/doe/myproject1")
 ;;       (kernel-style))

 ;;      ((match-path "~/myproject2")
 ;;       (android-style))

       ((match-path "~/SimTaDyn")
        (lecrapouille-style))

       (t (lecrapouille-style))))))

(defun add-kernel-style ()
  (c-add-style "linux-tabs-only"
   '("linux" (c-offsets-alist
              (arglist-cont-nonempty
               c-lineup-gcc-asm-reg
               c-lineup-arglist-tabs-only)))))

(defun add-lecrapouille-style ()
  (c-add-style "lecrapouille"
   '("gnu" (c-offsets-alist
            (arglist-cont-nonempty
             c-lineup-gcc-asm-reg
             c-lineup-arglist-tabs-only)))))

(add-hook 'c-mode-common-hook 'find-code-style)
(add-hook 'c-mode-common-hook 'add-kernel-style)
(add-hook 'c-mode-common-hook 'add-parrot-style)
(add-hook 'c-mode-common-hook 'add-lecrapouille-style)

;; Display function name in status-line
(which-function-mode 1)

;; Setup GDB: use gdb-many-windows by default and display source file
;; containing the main routine at startup
(setq
 gdb-many-windows t
 gdb-show-main t)
