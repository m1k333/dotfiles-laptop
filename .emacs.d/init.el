;;; $HOME/.emacs.d/init.el
;;; By Michael Richer
;;; Since May 5th, 2014

;;; Initialize stuff

;; Paths
(add-to-list 'load-path "~/.emacs.d/elisp")

;; Packages
(require 'package-populate)
(setq package-required-list '(auctex magit slime))

;;; Set up Emacs

;; Appearance
(blink-cursor-mode -1)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq custom-theme-directory "~/.emacs.d/themes/")
(when (display-graphic-p)
  (when (file-exists-p (concat custom-theme-directory "monokai-theme.el"))
    (setq monokai-distinct-fringe-background t)
    (load-theme 'monokai t))
  (when (eq system-type 'windows-nt)
    (set-face-attribute 'default nil :font "Consolas-12")))

;; Apropos
(setq apropos-do-all t)

;; Backups and autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir))
      auto-save-file-name-transforms `((".*" ,autosave-dir t))
      auto-save-list-file-prefix autosave-dir
      tramp-auto-save-directory autosave-dir
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 5)

;; Buffers
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Calendar and date stuff
(require 'calendar)
(calendar-set-date-style 'iso)
(require 'insert-date)

;; Case sensitivity
(setq completion-ignore-case t
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      pcomplete-ignore-case t
      eshell-cmpl-ignore-case t)

;; Commands
(setq disabled-command-hook nil)

;; Fill
(require 'unfill)

;; Flyspell
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Font lock
(setq global-font-lock-mode t)

;; Games
(autoload 'typing-of-emacs "typing-of-emacs.el"
  "The Typing of Emacs, a game." t)
      
;; Keybindings
(load-file "~/.emacs.d/keybindings.el")

;; LISP functionality
(require 'eval-and-replace)

;; Loading files
(setq load-prefer-newer t)

;; Mode line
(setq display-time-24hr-format t
      show-help-function nil)
(display-time-mode)
(line-number-mode)
(column-number-mode)
(size-indication-mode)
(tooltip-mode -1)

;; Mouse
(mouse-avoidance-mode 'banish)
(setq mouse-yank-at-point t)

;; Parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Recentf
(setq recentf-max-saved-items 50
      recentf-max-menu-items recentf-max-saved-items
      recentf-save-file "~/.emacs.d/recentf-file")
(recentf-mode 1)

;; Saveplace
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/saveplace-file")

;; SLIME
(setq inferior-lisp-program "/usr/bin/sbcl")
(when (featurep 'slime) (require 'slime))

;; Startup screen
(setq inhibit-startup-screen t
      initial-scratch-message ";; *scratch*\n\n")

;; Tabs
(setq-default indent-tabs-mode nil)

;; Text mode
(add-hook 'text-mode-hook 'auto-fill-mode)

;; Unicode
(prefer-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Username
(setq user-full-name "Michael Richer"
      user-mail-address "msricher1993@gmail.com")

;; X windows options
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t)

;; Yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;;; Finalizing
(switch-to-buffer "*scratch*")
(delete-other-windows)
