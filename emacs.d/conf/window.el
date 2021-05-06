(defalias 'yes-or-no-p 'y-or-n-p)

;; Display the file name in the window title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Remove all GUI
(setq column-number-mode t)
(setq line-number-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(toggle-scroll-bar -1)
;(global-visual-line-mode t)
(set-default 'truncate-lines t)

(defun disable-scrollbars (frame)
  (modify-frame-parameters frame
                           '((vertical-scroll-bars . nil)
                             (horizontal-scroll-bars . nil))))

(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow)
      alect-display-class '((class color) ; enable alect in 256-color terms
                            (min-colors 256)))

;; Add clock
(setq display-time-default-load-average nil)
(setq display-time-format "%H:%M")
(display-time)

;; Screen saver
;(require 'zone)
;(zone-when-idle 120)

;; Nyan cat
;; (nyan-mode)

; (load-theme 'alect-black t)
; (load-theme 'classic t)
(load-theme 'subatomic256 t)
; (load-theme 'nord t)
(set-face-attribute 'default nil :height 100) ; value in 1/10pt (100 = 10pts)

(when window-system
  (global-hl-line-mode 1))
