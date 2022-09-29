;;; carpalx-compat-mode.el -*- lexical-binding: t; -*-

(provide 'carpalx-compat-mode)
;; Makes some keymaps blank so that they can be rebound later
;; The main mode itself
(define-minor-mode carpalx-compat-mode
  "Overwrites annoying major mode binds"
  :global true
  :keymap (make-sparse-keymap)
  (evil-define-key '(normal visual motion) 'carpalx-compat-mode
    ;; stuff defined here will overwrite absolutley everything while carpalx-compat-mode is active. You have been warned
    (kbd "h") 'evil-forward-char
    (kbd "a") 'evil-backward-char
    (kbd "e") 'evil-next-line
    (kbd "o") 'evil-previous-line
    (kbd "C-a") 'evil-backward-word-begin
    (kbd "C-e") 'evil-forward-word-begin
    (kbd "w") 'evil-forward-word-begin
    (kbd "W") 'evil-forward-word-end)
  (evil-define-key 'normal 'global
    ;; binds defined here will only function during normal text editing
    [C-i] 'evil-append
    (kbd "E") 'evil-open-below
    (kbd "O") 'evil-open-above
    (kbd "za") '+fold/next
    (kbd "ze") '+fold/previous
    (kbd "U") 'undo-tree-visualize)
  (evil-define-key 'motion 'carpalx-compat-mode
    "gse" 'evilem-motion-next-line
    "gso" 'evilem-motion-previous-line)
  (evil-define-key 'normal 'global
    (kbd "C-f") 'evil-scroll-line-down
    (kbd "C-y") 'evil-scroll-line-up)
  (evil-define-key 'normal 'dired
    (kbd "C-c md") 'mkdir
    (kbd "C-c dd") 'delete-directory)
  (evil-define-key 'normal pdf-view-mode-map
    (kbd "a") 'evil-collection-pdf-view-previous-line-or-previous-page
    (kbd "e") 'evil-collection-pdf-view-next-line-or-next-page)
  (evil-define-key 'normal doc-view-mode-map
    (kbd "a") 'doc-view-previous-line-or-previous-page
    (kbd "e") 'doc-view-next-line-or-next-page)
  (evil-define-key 'normal dired-mode-map
    (kbd "a") 'evil-backward-char
    (kbd "e") 'evil-next-line
    (kbd "o") 'evil-previous-line
    (kbd "h") 'evil-forward-char)
  ;; For weird keymaps that overlap with my keymap
  (define-key indent-rigidly-map (kbd "a") 'indent-rigidly-left)
  (define-key indent-rigidly-map (kbd "e") 'indent-rigidly-right)
  )
