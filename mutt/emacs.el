(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(menu-bar-mode nil)
 '(tool-bar-mode nil nil (tool-bar))
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(lazy-highlight-cleanup nil)
 '(lazy-highlight-max-at-a-time nil)
 '(load-home-init-file t t)
 '(mouse-wheel-mode t)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Following was manually edited
;; =============================

;; Fun with the mouse cursor
(mouse-avoidance-mode (quote animate))

;; Truncate lines by default
(setq-default truncate-lines 1)
(setq-default truncate-partial-width-windows 1)

;; Typed text replaces the selection if the selection is active
;; Also allows to delete (not kill) the highlighted region by pressing <DEL>.
(delete-selection-mode t)

;; Use % to find the matching paren (as in vi).
;;   (http://www.gnu.org/software/emacs/emacs-faq.text)
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

;; Nuke all trailing spaces
;;   (http://www.splode.com/users/friedman/software/emacs-lisp)
(autoload 'nuke-trailing-whitespace "whitespace" nil t)

;; For mail
;;(load-library "post")
(load "~/.config/mutt/post")
(add-hook 'post-mode-hook
  (lambda()
    (auto-fill-mode t)
    (setq fill-column 72)    ; rfc 1855 for usenet messages
    (footmode-mode t)))