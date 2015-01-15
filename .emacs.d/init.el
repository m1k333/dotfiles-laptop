;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Repositories ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Initialize package extension
(package-initialize)

;;; Package repositories
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;;;;;;;;;;;;;
;; Settings ;;
;;;;;;;;;;;;;;

;;; Apropos
(setq apropos-do-all t)

;;; Auto-compression
(auto-compression-mode t)

;;; Backups
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

;;; Buffers

;; Suppress nonexistant file warnings
(setq confirm-nonexistent-file-or-buffer nil)

;; Allow creation of directories when finding files
(defun create-non-existent-directory ()
  "Check whether a given file's parent directories exist; if they do not, offer to create them."
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))
(add-to-list 'find-file-not-found-functions #'create-non-existent-directory)

;;; Diary
(setq diary-file "~/.emacs.d/diary")

;;; GUI settings
(unless window-system (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))
(if (fboundp 'transient-mark-mode) (transient-mark-mode 0))

;;; Ido mode
(setq ido-enable-flex-matching t
      ido-everywhere t)
(ido-mode 1)

;;; Mini-Buffer
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Mode line
(column-number-mode t)
(show-paren-mode t)
(size-indication-mode t)

;;; Personal information
(setq user-full-name "Michael Richer"
      user-mail-address "msricher1993@gmail.com")

;;; Saveplace
(require 'saveplace)
(setq save-place-file (concat user-emacs-directory "places"))
(setq-default save-place t)

;;; Scratch
(setq initial-scratch-message ";; *scratch*\n\n")

;;; SLIME
(setq inferior-lisp-program "/usr/bin/sbcl")

;;; Splash screen
(setq inhibit-splash-screen t)

;;; Syntax highlighting
(global-font-lock-mode t)
(show-paren-mode 1)

;;; Tabs, whitespace, etc.
(setq-default indent-tabs-mode nil)
(setq require-final-newline t)

;;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;; Xorg settings
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      mouse-yank-at-point t
      save-interprogram-paste-before-kill t)

;;;;;;;;;;;;;;;;;
;; Keybindings ;;
;;;;;;;;;;;;;;;;;

;;; From "Better Defaults"
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;; backward-kill-line
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom-set variables and faces ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(canlock-password "497aced1d6cb3a51488841058387b08293004137"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
