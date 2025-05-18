;;; -*- lexical-binding: t -*-

(custom-set-variables
 '(blink-cursor-mode nil) ; don't blink cursor
 '(column-number-mode t) ; show column numbers
 '(custom-enabled-themes '(wheatgrass))
 '(global-display-line-numbers-mode t) ; show static line numbers
 '(scroll-bar-mode nil) ; hide scrollbar
 '(tool-bar-mode nil) ; hide tool bar
 '(tooltip-mode nil)) ; hide tooltip

(custom-set-faces
 '(default ((t (
		:family "JetBrainsMono Nerd Font Mono"
		:foundry "nil"
	    	:slant normal
       		:weight medium
		:height 150
	       	:width normal)))))

;;; find-file-at-point bindings to use C-x C-f to go to files under cursor
;;; see https://stackoverflow.c:om/a/259376

(ffap-bindings)

;;; https://arne.me/blog/emacs-from-scratch-part-one-foundations
;;; https://www.reddit.com/r/emacs/comments/cbkmde/comment/eth2wl3
;;; hide startup message, open scratch at startup

(use-package emacs
  :init
  (setq-default inhibit-startup-screen t)
  (setq inhibit-splash-screen t)
  (setq inhibit-startup-message t)
  (setq initial-scratch-message nil)
  (setq initial-major-mode 'fundamental-mode)
  (defun display-startup-echo-area-message ()
    (message "")))

;;; use y or n in confirmation messages
(use-package emacs
  :init
  (defalias 'yes-or-no-p 'y-or-n-p))

;;; use utf-8
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

;;; map Cyrilic ЙЦУКЕН to Latin QWERTY
;;; may work only in standalone app, not in terminal due to C-<cyrilic char> not being sent
;;; https://www.reddit.com/r/emacs/comments/kbqdj7/comment/gfkodwo
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

