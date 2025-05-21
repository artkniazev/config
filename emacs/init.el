;;; -*- lexical-binding: t -*-

;; Structure inspired by https://github.com/LionyxML/emacs-solo/blob/main/init.el

;; https://www.melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(use-package emacs
  :ensure nil
  :bind
  (
   ;; C-RET inserts line below, doesn't split the line; C-S-RET inserts line above, same
   ;; https://web.archive.org/web/20241218055416/http://whattheemacsd.com/editing-defuns.el-01.html
   ("<C-return>" . (lambda ()
                     (interactive)
                     (end-of-line)
                     (newline)
                     (indent-for-tab-command)))
   ("<C-S-return>" . (lambda ()
                       (interactive)
                       (beginning-of-line)
                       (newline)
                       (forward-line -1)
                       (indent-for-tab-command)))
   
   ("M-/" . hippie-expand) ; instead of dabbrev-expand
   ("M-SPC" . cycle-spacing) ; cycle spaces instead of just-one-space
   ("C-x C-b" . ibuffer) ; ifbuffer instead of list-buffers
   
   ;; Restore Home&End keys behavior on MacOS
   ;; https://www.reddit.com/r/emacs/comments/j6vwa3/comment/g8111mv
   ("<home>" . 'move-beginning-of-line)
   ("<end>" . 'move-end-of-line)

   ;; Simplify commenting in terminal because it can't receive C-;
   ("C-x ;" . comment-line)

   ;; MacOS defaults Cmd-Up to beginning of file, Cmd-Down to end of file
   ("<s-up>" . beginning-of-buffer)
   ("<s-down>" . end-of-buffer)

   ;; https://github.com/LionyxML/emacs-solo/blob/main/init.el#L55
   ("M-o" . other-window)
   ("M-j" . duplicate-dwim)
   ("M-J" . (lambda () (interactive) (next-line) (join-line)))
   ("M-g r" . recentf)
   ("M-s f" . find-name-dired) ;; use * for fuzzy search
   )
  
  :init
  (defalias 'yes-or-no-p 'y-or-n-p)
  (defun display-startup-echo-area-message () (message ""))

  (select-frame-set-input-focus (selected-frame))
  (delete-selection-mode 1)
  (recentf-mode 1)
  (repeat-mode 1)
  (xterm-mouse-mode 1)
  (set-frame-font "JetBrainsMono Nerd Font Mono 16" nil t)
  (load-theme 'wheatgrass t)
  (blink-cursor-mode 0)
  (show-paren-mode 1)
  (pixel-scroll-precision-mode t) ; smooth scrolling in native app
  (recentf-mode 1) ; use M-x recentf-open-files
  (savehist-mode 1) ; history in C-s search and other minibuffers
  (save-place-mode 1) ; restore previous position in a file when opening
  (fido-mode 1)
  (global-auto-revert-mode 1) ;Global auto revert to reload files when they are changed on disk
  (auto-save-visited-mode +1) ; Auto save files on change

  ;; Show line numbers; set line number gutter min width
  (column-number-mode t)
  (global-display-line-numbers-mode t)
  (setq-default display-line-numbers-width 3
                display-line-numbers-widen t)
  
  ;; Use utf-8
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))
  (setq ring-bell-function (lambda ()
                           (invert-face 'mode-line)
                           (run-with-timer 0.05 nil 'invert-face 'mode-line)))

  (with-current-buffer (get-buffer-create "*scratch*")
    (insert (format "Loaded in %s. Activated packages: %s"
                    (emacs-init-time)
                    (number-to-string (length package-activated-list)))))
  
  :custom
  (history-length 100)
  (indent-tabs-mode nil)
  (use-dialog-box nil)
  (global-auto-revert-non-file-buffers t)
  (auto-revert-verbose nil)
  (auto-save-visited-interval 1)
  (backup-by-copying-when-linked t) ; Preserve hard links, https://emacs.stackexchange.com/a/4240
  
  ;; Hide startup message, open scratch at startup
  ;; https://arne.me/blog/emacs-from-scratch-part-one-foundations
  ;; https://www.reddit.com/r/emacs/comments/cbkmde/comment/eth2wl3
  (inhibit-startup-screen t)
  (inhibit-splash-screen t)
  (inhibit-startup-message t)
  (initial-scratch-message nil)
  (initial-major-mode 'fundamental-mode)

  ;; https://github.com/LionyxML/emacs-solo/blob/main/init.el
  (use-file-dialog nil)
  (use-dialog-box nil)
  (line-spacing nil)
  (completion-ignore-case t)
  (completions-detailed t)      
  (set-mark-command-repeat-pop t) ; So we can use C-u C-SPC C-SPC C-SPC... instead of C-u C-SPC C-u C-SPC...
  (treesit-font-lock-level 4)

  ;; Smooth scrolling in native app
  (pixel-scroll-precision-mode t)
  (pixel-scroll-precision-use-momentum nil)
  (scroll-conservatively 100)
  (scroll-margin 0)

  ;; no backup
  (create-lockfiles nil)
  (make-backup-files nil)
  (backup-inhibited t)

  :config
  ;; Custom options go to a separate file
  (setq custom-file "~/.config/emacs/custom.el") 
  (load-file custom-file)

  ;; C-w to kill line if no region selected, else default kill-region
  ;; M-w to copy line if no region selected, else default kill-ring-save
  ;; https://emacs.stackexchange.com/a/2348
  (defun slick-cut (beg end)
    (interactive
     (if mark-active
         (list (region-beginning) (region-end))
       (list (line-beginning-position) (line-beginning-position 2)))))
  (defun slick-copy (beg end)
    (interactive
     (if mark-active
         (list (region-beginning) (region-end))
       (message "Copied line")
       (list (line-beginning-position) (line-beginning-position 2)))))
  (advice-add 'kill-region :before #'slick-cut)
  (advice-add 'kill-ring-save :before #'slick-copy)

  )

(use-package isearch
  :ensure nil
  :defer t
  :config
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "(%s/%s) ")
  (setq lazy-count-suffix-format nil)
  (setq search-whitespace-regexp ".*?")
  
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
  (define-key isearch-mode-map [remap isearch-delete-char] 'isearch-del-char))

(use-package vc
  :ensure nil
  :defer t
  :config
  (setq vc-directory-exclusion-list '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn"".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" ".svn" ".jj" ".git" ".hg" "node_modules" "build" "dist")
        vc-make-backup-files nil
        vc-follow-symlinks t))

;;; https://github.com/LionyxML/emacs-solo/blob/main/init.el#L290
(use-package compile
  :ensure nil
  :defer t
  :custom
  (compilation-always-kill t)
  (compilation-scroll-output t)
  (ansi-color-for-compilation-mode t))

(use-package dired
  :ensure nil
  :defer t
  :custom
  (dired-dwim-target t))

(use-package wdired
  :ensure nil
  :defer t
  :custom
  (wdired-allow-to-change-permissions t)
  (wdired-create-parent-directories t))

(use-package auth-source
  :ensure nil
  :defer t
  :config
  (setq user-full-name "Artem E. Knyazev"
	      user-mail-address "artem.e.knyazev@gmail.com"))

(use-package smex
  :ensure t
  :defer t
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)))

(use-package helm
  :ensure t
  :defer t)

(use-package magit
  :ensure t
  :defer t)

(use-package projectile
  :ensure t
  :defer t
  :init
  (projectile-mode +1)
  :bind
  ("s-p" . projectile-command-map))

(use-package go-mode
  :ensure t
  :defer t)


;;; --- Scripts ---

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
             (kbd (concat "C-M-" (string to))))
 (define-key function-key-map
             (kbd (concat "s-" (string from)))
             (kbd (concat "s-" (string to)))))
