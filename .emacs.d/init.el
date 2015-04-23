;;; init.el - Michael Richer - May 5th, 2014

;; Appearance
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode 1))

;; Apropos
(setq apropos-do-all t)

;; Backups
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;; Commands
(setq disabled-command-hook nil)

;; Parentheses
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Saveplace
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;; Start-up
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";; *scratch*\n\n")

;; Syntax highlighting
(setq font-lock-maximum-decoration t)

;; Tabs
(setq-default indent-tabs-mode nil)

;;; Keybindings
(global-set-key (kbd "M-/") 'hippie-expand)
