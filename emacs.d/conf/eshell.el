(setq eshell-history-size 10000)

(defun eshell/e (file)
  (find-file file))

(defun eshell/ll (&optional args)
  (eshell/ls "-lrth" args))

(defun eshell/la (&optional args)
  (eshell/ls "-lArth" args))

(defun eshell/ssh (name)
  (insert (concat "cd /ssh:" name ":~"))
  (eshell-send-input))

;; makes Eshell’s `ls' file names RET-able
(with-eval-after-load "em-ls"
  (defun ted-eshell-ls-find-file-at-point (point)
    "RET on Eshell's `ls' output to open files."
    (interactive "d")
    (find-file (buffer-substring-no-properties
                (previous-single-property-change point 'help-echo)
                (next-single-property-change point 'help-echo))))

  (defun pat-eshell-ls-find-file-at-mouse-click (event)
    "Middle click on Eshell's `ls' output to open files.
 From Patrick Anderson via the wiki."
    (interactive "e")
    (ted-eshell-ls-find-file-at-point (posn-point (event-end event))))

  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "RET")      'ted-eshell-ls-find-file-at-point)
    (define-key map (kbd "<return>") 'ted-eshell-ls-find-file-at-point)
    (define-key map (kbd "<mouse-2>") 'pat-eshell-ls-find-file-at-mouse-click)
    (defvar ted-eshell-ls-keymap map))

  (defadvice eshell-ls-decorated-name (after ted-electrify-ls activate)
    "Eshell's `ls' now lets you click or RET on file names to open them."
    (add-text-properties 0 (length ad-return-value)
                         (list 'help-echo "RET, mouse-2: visit this file"
                               'mouse-face 'highlight
                               'keymap ted-eshell-ls-keymap)
                         ad-return-value)
    ad-return-value))

(defun eshell-git-prompt-clem ()
  ;; Prompt components
  (let (beg dir git-branch git-dirty end)
    ;; Beg: start symbol
    (setq beg
          (with-face "➜"
            :foreground (if (eshell-git-prompt-exit-success-p)
                            "green" "red")))

    ;; Dir: current working directory
    (setq dir (with-face (substring (abbreviate-file-name default-directory) 0 -1)
                :foreground "cyan"))

    ;; Git: branch/detached head, dirty status
    (when (eshell-git-prompt--git-root-dir)
      (setq eshell-git-prompt-branch-name (eshell-git-prompt--branch-name))

      (setq git-branch
            (concat
             (with-face "git:(" :foreground "blue")
             (with-face (eshell-git-prompt--readable-branch-name) :foreground "red")
             (with-face ")" :foreground "blue")))

      (setq git-dirty
            (when (eshell-git-prompt--collect-status)
              (with-face "✗" :foreground "yellow"))))

    ;; End: To make it possible to let `eshell-prompt-regexp' to match the full prompt
    (setq end (propertize "$" 'invisible t))

    ;; Build prompt
    (concat (s-join " " (-non-nil (list beg dir git-branch git-dirty)))
            end
            " ")))

(require 'eshell-git-prompt)
(add-to-list 'eshell-git-prompt-themes '(clem
                                         eshell-git-prompt-clem
                                         eshell-git-prompt-robbyrussell-regexp))
(eshell-git-prompt-use-theme 'clem)

;; eshell coloration
(add-hook 'eshell-mode-hook
          '(lambda ()
             (setenv "TERM" "xterm")))

;; for some reason this needs to be a hook
(add-hook 'eshell-mode-hook
          '(lambda ()
             (evil-define-key 'normal eshell-mode-map
               (kbd "<RET>") 'eshell-send-input)))

;; TODO those two functions are dirty, clean them
;; set evil-comptatible properties and toggle read-only
(defun protect-eshell-prompt ()
  "Protect Eshell's prompt like Comint's prompts.
E.g. `evil-change-whole-line' won't wipe the prompt. This
is achieved by adding the relevant text properties."
  (interactive)
  (let ((inhibit-field-text-motion t))
    (add-text-properties
     (point-at-bol)
     (point)
     '(rear-nonsticky t
                      inhibit-line-move-field-capture t
                      field output
                      read-only t
                      front-sticky (field inhibit-line-move-field-capture)))))

(add-hook 'eshell-after-prompt-hook 'protect-eshell-prompt)

;; temporarily remove the read-only attribute of the prompt
;; by rewriting eshell-emit-prompt
(defun my-eshell-emit-prompt (orig-fun &rest args)
  "Emit a prompt if eshell is being used interactively."
  (run-hooks 'eshell-before-prompt-hook)
  (if (not eshell-prompt-function)
      (set-marker eshell-last-output-end (point))
    (let ((prompt (funcall eshell-prompt-function)))
      (and eshell-highlight-prompt
           (add-text-properties
            0 (length prompt)
            '(read-only nil
                        font-lock-face eshell-prompt
                        front-sticky (font-lock-face read-only)
                        rear-nonsticky (font-lock-face read-only))
            prompt))
      (eshell-interactive-print prompt)))
  (run-hooks 'eshell-after-prompt-hook))

(advice-add 'eshell-emit-prompt :around #'my-eshell-emit-prompt)
