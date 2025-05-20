;;; -*- lexical-binding: t -*-

;;; --- Packages ---

;; https://www.melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; https://emacs.stackexchange.com/a/28933
;; Try changing to for all required packages
;; (use-package go-mode :ensure t)
(dolist (package '(use-package smex magit go-mode helm))
 (unless (package-installed-p package)
   (package-install package)))

;;; --- Custom options ---

(setopt user-full-name "Artem E. Knyazev"
	user-mail-address "artem.e.knyazev@gmail.com")

;; Custom options go to a separate file
(setq custom-file "~/.config/emacs/custom.el") 
(load-file custom-file)

;; Font, theme
(set-frame-font "JetBrainsMono Nerd Font Mono 16" nil t)
(load-theme 'wheatgrass t)

;; Remove unnecessary UI elements
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tooltip-mode 1)

;; Convenience
(blink-cursor-mode 0)
(show-paren-mode 1)
(pixel-scroll-precision-mode t) ; smooth scrolling in native app

;; Indentation
(setq-default indent-tabs-mode nil)

;; Show line numbers; set line number gutter min width
(column-number-mode t)
(global-display-line-numbers-mode t)
(setq-default display-line-numbers-width 3)

;; https://youtu.be/51eSeqcaikM?list=PLEoMzSkcN8oNmd98m_6FoaJseUsa6QGm2
(recentf-mode 1) ; use M-x recentf-open-files
(setq history-length 100)
(savehist-mode 1) ; history in C-s search and other minibuffers
(save-place-mode 1) ; restore previous position in a file when opening
(setq use-dialog-box nil)

;; Mute a follow symlinks question
;; https://stackoverflow.com/a/30900018
(setq vc-follow-symlinks t)

;; Preserve hard links
;; https://emacs.stackexchange.com/a/4240
(setq backup-by-copying-when-linked t)

;; Wrap search -- when fail type again C-s to continue from above
;; https://stackoverflow.com/a/287067
(defadvice isearch-search (after isearch-no-fail activate)
  (unless isearch-success
    (ad-disable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)
    (isearch-repeat (if isearch-forward 'forward))
    (ad-enable-advice 'isearch-search 'after 'isearch-no-fail)
    (ad-activate 'isearch-search)))
;; Prevents issue where you have to press backspace twice when
;; trying to remove the first character that fails a search
(define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char)

;; Don't beep. Just blink the modeline on errors.
;; https://web.archive.org/web/20241218055416/http://whattheemacsd.com/appearance.el-02.html
(setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; https://emacsredux.com/blog/2022/06/03/enable-mouse-support-in-terminal-emacs/
(xterm-mouse-mode 1)

;; https://wikemacs.org/wiki/Smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; FIDO
(fido-mode 1)

;; Global auto revert to reload files when they are changed on disk
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(global-auto-revert-mode 1)

;; https://www.reddit.com/r/emacs/comments/1aufydk/comment/kr4qu0v
;; Auto save files on change
(auto-save-visited-mode +1)
(setq auto-save-visited-interval 1)

;; Dired
(require 'dired-x)


;;; --- Custom shortcuts ---

;; C-RET inserts line below, doesn't split the line; C-S-RET inserts line above, same
;; https://web.archive.org/web/20241218055416/http://whattheemacsd.com/editing-defuns.el-01.html
(global-set-key
 (kbd "<C-return>")
 (lambda ()
   (interactive)
   (end-of-line)
   (newline)
   (indent-for-tab-command)))

(global-set-key
 (kbd "<C-S-return>")
 (defun open-line-above ()
   (interactive)
   (beginning-of-line)
   (newline)
   (forward-line -1)
   (indent-for-tab-command)))

;; Map C-x C-b to ibuffer instead
(global-set-key [remap list-buffers] 'ibuffer)
;; M-SPC cycles spaces instead of removing space
(global-set-key [remap just-one-space] 'cycle-spacing)

;; Restore Home&End keys behavior on MacOS
;; https://www.reddit.com/r/emacs/comments/j6vwa3/comment/g8111mv
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)

;; Simplify commenting in terminal because it can't receive C-;
(global-set-key (kbd "<C-x ;>") 'comment-line)

;; M-/ to hippie expand
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; MacOS defaults Cmd-Up to beginning of file, Cmd-Down to end of file
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "<s-down>") 'end-of-buffer)


;;; --- Package-specific options ---

;; https://arne.me/blog/emacs-from-scratch-part-one-foundations
;; https://www.reddit.com/r/emacs/comments/cbkmde/comment/eth2wl3
;; Hide startup message, open scratch at startup
(use-package emacs
  :init
  (setq-default inhibit-startup-screen t)
  (setq inhibit-splash-screen t)
  (setq inhibit-startup-message t)
  (setq initial-scratch-message nil)
  (setq initial-major-mode 'fundamental-mode)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (defun display-startup-echo-area-message ()
    (message "")))

;; Use utf-8
(use-package emacs
  :init
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix)))

;; Map Cyrilic ЙЦУКЕН to Latin QWERTY
;; May work only in native app, not in terminal due to C-<cyrilic char> not being sent
;; https://www.reddit.com/r/emacs/comments/kbqdj7/comment/gfkodwo
(require 'cl-lib)
(cl-loop
 for from across "1234567890-=йцукенгшщзхъфывапролджэёячсмитьбю/!\"№%:,.;()_+ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮ?"
 for to   across "1234567890-=qwertyuiop[]asdfghjkl;'\\zxcvbnm,./!@#$%^&*()_+QWERTYUIOP{}ASDFGHJKL:\"|ZXCVBNM<>?"
 do
 (define-key function-key-map
             (kbd (string from))
             (kbd (string to)))
 (define-key function-key-map
             (kbd (concat "C-" (string from)))
             (kbd (concat "C-" (string to))))
 (define-key function-key-map
             (kbd (concat "M-" (string from)))
             (kbd (concat "M-" (string to))))
 (define-key function-key-map
             (kbd (concat "C-M-" (string from)))
             (kbd (concat "C-M-" (string to)))))
