;; Additional hacks from:
;; - https://github.com/LionyxML/emacs-solo/blob/main/early-init.el

;; Increase startup speed
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      vc-handled-backends '(Git))
(setq inhibit-compacting-font-caches t)

;; HACK: avoid being flashbanged
(defun emacs-solo/avoid-initial-flash-of-light ()
  "Avoid flash of light when starting Emacs."
  (setq mode-line-format nil)
  ;; These colors should match your selected theme for maximum effect
  (set-face-attribute 'default nil :background "black" :foreground "black"))

(defun emacs-solo/reset-default-foreground ()
  "Reset the foreground color of the default face."
    (set-face-attribute 'default nil :foreground (face-foreground 'default)))

(emacs-solo/avoid-initial-flash-of-light)                           ; HACK start
(add-hook 'after-init-hook #'emacs-solo/reset-default-foreground)   ; HACK undo

;; Better window resizing
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t)

;; Prevent screen from flashing set colors&font and hide menu bars early
(load-theme 'wheatgrass t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tooltip-mode 0)
(fringe-mode 0)

;; https://stackoverflow.com/a/79042584
(when initial-window-system ;; i-w-s from stack exchange
  (add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font Mono 16")))

;; https://emacsredux.com/blog/2020/12/04/maximize-the-emacs-frame-on-startup/
;; Start the initial frame maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; Start every frame maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Avoid raising the *Messages* buffer if anything is still without
;; lexical bindings
(setq warning-minimum-level :error)
(setq warning-suppress-types '((lexical-binding)))
