; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)
(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

; Style
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(fringe-mode 30)
(require-package 'base16-theme)
(load-theme 'base16-tomorrow-night t)
(set-face-attribute 'fringe nil :background nil)

; Evil
;; Installation and setup
(require-package 'evil)
(setq evil-want-Y-yank-to-eol t)
(require 'evil)
(evil-mode 1)
;; Different colors and styles for different modes
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

; Neotree
(require-package 'neotree)
(setq neo-theme 'arrow)
;; Neotree is on the right
(setq neo-window-position 'right)
;; Open neotree via tab in normal mode
(define-key evil-normal-state-map (kbd "TAB") 'neotree-toggle)
;; Open buffers list on ctrl-space
(define-key evil-normal-state-map (kbd "C-SPC") 'ivy-switch-buffer)
;; Open fuzzy finder with ctrl-p
(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)

; Evil-Leader
;; Installation and setup
(require-package 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(setq evil-leader/in-all-states 1)

; Esc Quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
  In Delete Selection mode, if the mark is active, just deactivate it;
  then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
    (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

; Smooth Scrolling
;; Installation and setup
(require-package 'smooth-scrolling)
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

; Autopair
(require-package 'autopair)
(require 'autopair)
(autopair-global-mode)

; Ivy
(require-package 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
;; Escape in ivy
(require 'ivy)
(define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)

; Disable backup files
(setq make-backup-files nil)

; iBuffer
(eval-after-load 
  'ibuffer
  '(progn
     (evil-set-initial-state 'ibuffer-mode 'normal)
     (evil-define-key 'normal ibuffer-mode-map
                      (kbd "j") 'evil-next-line
                      (kbd "k") 'evil-previous-line)))
;; Custom stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb" "e1498b2416922aa561076edc5c9b0ad7b34d8ff849f335c13364c8f4276904f0" default)))
 '(package-selected-packages (quote (smooth-scrolling evil-leader))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
