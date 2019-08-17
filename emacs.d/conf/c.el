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

(defun google-c-style ()
  (print "I'm now using the Google C style")
  (setq indent-tabs-mode nil)
  (whitespace-mode)
  (google-set-c-style)
  (setq c-basic-offset 4))

(defun kernel-c-style ()
  (print "I'm now using the kernel C style")
  (setq indent-tabs-mode t)
  (whitespace-mode)
  (c-set-style "linux-tabs-only"))

(defun lecrapouille-c-style()
  (print "I'm now using the QQ C style")
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

(defun match-partial-path (path)
  (string-match path filename))

(defun find-code-style ()
  (when (buffer-file-name)
    (let ((filename (file-truename (buffer-file-name))))
      (cond

 ;; Define your coding style for eachs projects of yours. Some examples are given here
 ;;      ((match-path "~/home/john/doe/myLinuxKernelproject")
 ;;       (kernel-c-style))

 ;;      ((match-path "~/myAndroidProject")
 ;;       (android-c-style))

 ;; Lecrapouille's coding style
       ((match-partial-path "SimTaDyn")
        (lecrapouille-c-style))

       (t (lecrapouille-c-style))))))

(add-hook 'c-mode-common-hook 'find-code-style)

;; Display function name in status-line
(which-function-mode 1)

;; Setup GDB: use gdb-many-windows by default and display source file
;; containing the main routine at startup
(setq
 gdb-many-windows t
 gdb-show-main t)
