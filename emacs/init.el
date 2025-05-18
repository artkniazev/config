;;; -*- lexical-binding: t -*-
;; https://www.melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; https://wikemacs.org/wiki/Smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; https://www.masteringemacs.org/article/introduction-to-ido-mode
;; Interactive Do It mode; pressing tab shows autocompletion
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(set-frame-font "JetBrainsMono Nerd Font Mono 15" nil t)
(load-theme 'wheatgrass t)
(blink-cursor-mode 0)
(tool-bar-mode 0)
(tooltip-mode 1)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(column-number-mode t)
(global-display-line-numbers-mode t)

;; find-file-at-point bindings to use C-x C-f to go to files under cursor
;; see https://stackoverflow.c:om/a/259376
(ffap-bindings)

;; global auto revert to reload files when they are changed on disk
(global-auto-revert-mode 1)

;; https://www.reddit.com/r/emacs/comments/1aufydk/comment/kr4qu0v
;; auto save files on change
(auto-save-visited-mode +1)
(setq auto-save-visited-interval 1)

;; https://emacsredux.com/blog/2020/12/04/maximize-the-emacs-frame-on-startup/
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; https://arne.me/blog/emacs-from-scratch-part-one-foundations
;; https://www.reddit.com/r/emacs/comments/cbkmde/comment/eth2wl3
;; hide startup message, open scratch at startup
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

;; use utf-8
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

;; map Cyrilic ЙЦУКЕН to Latin QWERTY
;; may work only in standalone app, not in terminal due to C-<cyrilic char> not being sent
;; https://www.reddit.com/r/emacs/comments/kbqdj7/comment/gfkodwo
(require 'cl-lib)
(cl-loop
  for from across "1234567890-=йцукенгшщзхъфывапролджэёячсмитьбю/!\"№%:,.;()_+ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮ?"
  for to   across "1234567890-=qwertyuiop[]asdfghjkl;'\\zxcvbnm,./!@#$%^&*()_+QWERTYUIOP{}ASDFGHJKL:\"|ZXCVBNM<>?"
  do
  (define-key function-key-map
    (kbd (string from)) (kbd (string to)))
  (define-key function-key-map
    (kbd (concat "C-" (string from))) (kbd (concat "C-" (string to))))
  (define-key function-key-map
    (kbd (concat "M-" (string from))) (kbd (concat "M-" (string to))))
  (define-key function-key-map
    (kbd (concat "C-M-" (string from))) (kbd (concat "C-M-" (string to)))))

