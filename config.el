;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;(setq user-full-name "John Doe"
;;      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-snazzy)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
;; Defines indent-guides
(setq highlight-indent-guides-method 'column)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(add-to-list 'load-path "~/.doom.d/custom/")
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
                                        ;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Minor mode stuff
;; (define-minor-mode carpalx-compat-mode
;;   "Overwrites annoying major mode binds"
;;   :global true
;;   (evil-define-key '(normal visual motion) 'carpalx-compat-mode
;;     ;; stuff defined here will overwrite absolutley everything while carpalx-compat-mode is active. You have been warned
;;     (kbd "h") 'evil-forward-char
;;     (kbd "a") 'evil-backward-char
;;     (kbd "e") 'evil-next-line
;;     (kbd "o") 'evil-previous-line
;;     (kbd "C-a") 'evil-backward-word-begin
;;     (kbd "C-e") 'evil-forward-word-begin
;;     (kbd "w") 'evil-forward-word-begin
;;     (kbd "W") 'evil-forward-word-end)
;;   (evil-define-key 'normal 'global
;;     ;; binds defined here will only function during normal text editing
;;     [C-i] 'evil-append
;;     (kbd "E") 'evil-open-below
;;     (kbd "O") 'evil-open-above
;;     (kbd "za") '+fold/next
;;     (kbd "ze") '+fold/previous
;;     (kbd "U") 'undo-tree-visualize)
;;   (evil-define-key 'motion 'carpalx-compat-mode
;;     "gse" 'evilem-motion-next-line
;;     "gso" 'evilem-motion-previous-line)
;;   (evil-define-key 'normal 'global
;;     (kbd "C-f") 'evil-scroll-line-down
;;     (kbd "C-y") 'evil-scroll-line-up)
;;   (evil-define-key 'normal 'dired
;;     (kbd "C-c md") 'mkdir
;;     (kbd "C-c dd") 'delete-directory)
;;   (evil-define-key 'insert pdf-view-mode-map
;;     (kbd "a") 'evil-collection-pdf-view-previous-line-or-previous-page
;;     (kbd "e") 'evil-collection-pdf-view-next-line-or-next-page)
;;   (evil-define-key 'normal dired-mode-map
;;     (kbd "a") 'evil-backward-char
;;     (kbd "e") 'evil-next-line
;;     (kbd "o") 'evil-previous-line
;;     (kbd "h") 'evil-forward-char)
;;   ;; Keybinds for emacs mode
;;   ;(define-key pdf-view-mode-map (kbd "a") 'pdf-view-previous-line-or-previous-page)
;;   ;(define-key pdf-view-mode-map (kbd "e") 'pdf-view-next-line-or-next-page)
;;   ;;Required modes for this to play nice
;;   (evil-mode t))
(require 'carpalx-compat-mode)
;; Mode specific functions
(evil-set-initial-state 'pdf-view-mode 'emacs)
;;makes image mode not be a pain
(define-key image-map (kbd "o") nil)

;;enables disabled commands
(defun enable-all-commands ()
  "Enable all commands, reporting on which were disabled."
  (interactive)
  (with-output-to-temp-buffer "*Commands that were disabled*"
    (mapatoms
     (function
      (lambda (symbol)
        (when (get symbol 'disabled)
          (put symbol 'disabled nil)
          (prin1 symbol)
          (princ "\n")))))))

;; Thing for migrating notes to org-roam
(defun org-roam-create-note-from-headline ()
  "Create an Org-roam note from the current headline and jump to it.
Normally, insert the headline’s title using the ’#title:’ file-level property
and delete the Org-mode headline. However, if the current headline has a
Org-mode properties drawer already, keep the headline and don’t insert
‘#+title:'. Org-roam can extract the title from both kinds of notes, but using
‘#+title:’ is a bit cleaner for a short note, which Org-roam encourages."
  (interactive)
  (let ((title (nth 4 (org-heading-components)))
        (has-properties (org-get-property-block)))
    (org-cut-subtree)
    (org-roam-find-file title nil nil 'no-confirm)
    (org-paste-subtree)
    (unless has-properties
      (kill-line)
      (while (outline-next-heading)
        (org-promote)))
    (goto-char (point-min))
    (when has-properties
      (kill-line)
      (kill-line))))

;; package config stuff
(use-package dirvish
  ;;  :ensure t
  :init
  ;; Let Dirvish take over Dired globally
  (dirvish-override-dired-mode))

;; Leader key binds
(map! :leader
      "wh" #'evil-window-right
      "wa" #'evil-window-left
      "we" #'evil-window-down
      "wo" #'evil-window-up
      "wA" #'+evil/window-move-left
      "wO" #'+evil/window-move-up
      "wH" #'+evil/window-move-right
      "wE" #'+evil/window-move-down
      "ws" #'ace-window
      "w/" #'evil-window-split
      "o-" #'dirvish
      "oc" #'calc
      "fd" #'dirvish
      "op" #'pass
      "th" #'hs-toggle-hiding
      "tkm" #'carpalx-compat-mode)
(map! :after dirvish
      :map dirvish-mode-map
      :localleader
      "md" #'dired-create-directory)
(map! :after 'pdf-view-mode-map
      :map carpalx-compat-mode
      (kbd "a") #'evil-collection-pdf-view-previous-line-or-previous-page
      (kbd "e") #'evil-collection-pdf-view-next-line-or-next-page)
(map! :after org
      :map org-mode-map
      :localleader
      "bS" #'org-table-shrink
      "bE" #'org-table-expand)
;; Org-mode config
(setq org-startup-folded t)
(setq org-startup-shrink-all-tables t)
(setq org-startup-align-all-tables t)
;;activating modes
(carpalx-compat-mode t)
(ace-window-display-mode t)
;;(vimish-fold-global-mode t)
(global-tree-sitter-mode t)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
;;(global-org-modern-mode t)
(vimish-fold-global-mode t)
;; Functions for hooks
(defun pdf-keymap-compatibility ()
 ;; Takes Precedence over minor mode keymaps
 (evil-local-set-key 'normal (kbd "a") 'pdf-view-previous-line-or-previous-page)
 (evil-local-set-key 'normal (kbd "e") 'pdf-view-next-line-or-next-page)
 )
;;Hooks
(add-hook!
 'global 'hs-minor-mode
 'pdf-view-mode-hook #'pdf-keymap-compatibility)

(server-start)
