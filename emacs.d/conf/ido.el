(ido-mode 1)
(ido-everywhere 1) ; rgrep
(ido-ubiquitous-mode 1) ; C-h f

;; Emacs 25.1.91 does not allow setq to have one argument.
;; TODO: patch smex.
(require 'smex)
(defun smex-load-save-file ()
  "Loads `smex-history' and `smex-data' from `smex-save-file'"
  (let ((save-file (expand-file-name smex-save-file)))
    (if (file-readable-p save-file)
        (with-temp-buffer
          (insert-file-contents save-file)
          (condition-case nil
              (setq smex-history (read (current-buffer))
                    smex-data    (read (current-buffer)))
            (error (if (smex-save-file-not-empty-p)
                       (error "Invalid data in smex-save-file (%s). Can't restore history."
                              smex-save-file)
                     (if (not (boundp 'smex-history)) (setq smex-history nil))
                     (if (not (boundp 'smex-data))    (setq smex-data nil))))))
      (setq smex-history nil smex-data nil))))

(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(setq ido-enable-tramp-completion nil ; because it hangs
      gc-cons-threshold 20000000 ; modern machine
      ido-enable-flex-matching t)

;; magit
(define-key ido-common-completion-map
  (kbd "C-x g") 'ido-enter-magit-status)

;; eshell TODO: clean this
(defun eshell-kill-maybe ()
  (interactive)
  (if (equal (current-buffer) (get-buffer "*eshell*"))
      (let ((dd default-directory))
        (kill-buffer "*eshell*")
        (with-temp-buffer
          (setq default-directory dd)
          (call-interactively 'eshell)))
    (kill-buffer-maybe "*eshell*")
    (call-interactively 'eshell)))

(defun ido-exit-with-eshell ()
  (interactive)
  (with-no-warnings
    (setq ido-exit 'fallback fallback 'eshell-kill-maybe))
  (exit-minibuffer))

(define-key ido-common-completion-map
  (kbd "C-x e") 'ido-exit-with-eshell)

;; shell TODO: clean this
(defun shell-kill-maybe ()
  (interactive)
  (when (get-buffer "*shell*")
    (set-process-query-on-exit-flag
     (get-buffer-process (get-buffer "*shell*")) nil))
  (if (equal (current-buffer) (get-buffer "*shell*"))
      (let ((dd default-directory))
        (kill-buffer "*shell*")
        (with-temp-buffer
          (setq default-directory dd)
          (call-interactively 'shell)))
    (kill-buffer-maybe "*shell*")
    (call-interactively 'shell)))

(defun ido-exit-with-shell ()
  (interactive)
  (with-no-warnings
    (setq ido-exit 'fallback fallback 'shell-kill-maybe))
  (exit-minibuffer))

(define-key ido-common-completion-map
  (kbd "C-x s") 'ido-exit-with-shell)

;; ansi-term TODO: clean this
(defun ansi-term-kill-maybe ()
  (interactive)
  (when (get-buffer "*ansi-term*")
    (set-process-query-on-exit-flag
     (get-buffer-process (get-buffer "*ansi-term*")) nil))
  (if (equal (current-buffer) (get-buffer "*ansi-term*"))
      (let ((dd default-directory))
        (kill-buffer "*ansi-term*")
        (with-temp-buffer
          (setq default-directory dd)
          (ansi-term "/bin/bash")))
    (kill-buffer-maybe "*ansi-term*")
    (ansi-term "/bin/bash")))

(defun ido-exit-with-ansi-term ()
  (interactive)
  (with-no-warnings
    (setq ido-exit 'fallback fallback 'ansi-term-kill-maybe))
  (exit-minibuffer))

(define-key ido-common-completion-map
  (kbd "C-x d") 'ido-exit-with-ansi-term)

;; yank
(defun ido-exit-with-yank ()
  (interactive)
  (with-no-warnings
    (setq ido-exit 'fallback fallback
          (lambda () (interactive) (kill-new default-directory))))
  (exit-minibuffer))

(define-key ido-common-completion-map
  (kbd "C-x y") 'ido-exit-with-yank)

;; xterm
(defun spawn-xterm ()
  (interactive)
  (let ((cmd (concat "xterm -e \" cd " default-directory " && /bin/bash\"")))
    (start-process-shell-command "xterm" "xterm" cmd)))

(defun ido-exit-with-xterm ()
  (interactive)
  (with-no-warnings
    (setq ido-exit 'fallback fallback 'spawn-xterm))
  (exit-minibuffer))

(define-key ido-common-completion-map
  (kbd "C-x x") 'ido-exit-with-xterm)
