(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.org/packages/")))

;; Add elpa packages here
(require 'package)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(mapc
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 '(subatomic-theme
   subatomic256-theme
   alect-themes
   bind-map
   dactyl-mode
   debbugs
   dockerfile-mode
   eshell-git-prompt
   evil-mc
   fic-mode
   ggtags
   hackernews
   ;;irfc
   jabber
   nhexl-mode
   pass
   password-store
   repo
   xkcd
   magit
   pdf-tools
   smex
   iedit
   google-c-style
   rainbow-delimiters
   flx-ido
   ido-completing-read+
   smex
   ;;header2
   markdown-mode
   julia-mode
   ))

;; Call .el file
(mapc
 (lambda (conf-file)
   (load (concat "~/.emacs.d/conf/" conf-file)))
 (mapcar 'symbol-name
         '(window
           color
           base
           ;evil
           ;evil-cursors
           parenthesis
           misc
           spaces
           paragraph
           epita
           rebox
           abbrev
           search
           headers
           makefiles
           gtags
           c
           forth
           python
           xml
           sh
           term
           eshell
           ediff
           ibuffer
           ; lisp
           ido
           repo
           bindings
           )))

(require 'server)
(unless (server-running-p) (server-start))
