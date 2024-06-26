;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Yoandre Saavedra"
      user-mail-address "yoandre.saavedra@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 16 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "Fira Sans" :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-palenight)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
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

;; Enable pyvenv
(use-package! pyvenv
  :config
  ;; Automatically use the virtualenv defined in a `.venv` file
  (pyvenv-mode 1))

(add-hook 'python-mode-hook
          (lambda ()
            (when (file-exists-p (expand-file-name ".venv" (projectile-project-root)))
              (pyvenv-activate (expand-file-name ".venv" (projectile-project-root))))))

(setq projectile-indexing-method 'alien)
;; (setq projectile-require-project-root nil)
;;
;; Optionally, display the current virtual environment in the mode line
;; (setq pyvenv-mode-line-indicator '(pyvenv-virtual-env-name (" venv:" pyvenv-virtual-env-name " ")))
;


(use-package! lsp-tailwindcss)



(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 3
        company-show-numbers t)
  (add-hook
   'evil-normal-state-entry-hook #'company-abort))



;; (use-package! lsp-mode
;;   :hook (python-mode . lsp)
;;   :config
;;   (setq lsp-pyright-python-executable-cmd "python"
;;         lsp-pyright-multi-root nil
;;         lsp-pyright-auto-import-completions t
;;         lsp-pyright-use-library-code-for-types t))

;; (use-package! lsp-pyright
;;   :ensure t
;;   :after lsp-mode
;;   :hook (python-mode . (lambda ()
;;                          (require 'lsp-pyright)
;;                          (lsp))))


;; (setq lsp-pylsp-plugins-flake8-max-line-length 88)

(use-package! org-super-agenda
  :after org-agenda
  :ensure t
  :init
  (setq org-super-agenda-groups '((:name "Today"
                                        :time-grid t
                                        :sheduled today)
                                  (:name "Due today"
                                        :deadline today)
                                  (:name "Important"
                                         :priority "A")
                                  (:name "Overdue"
                                         :deadline past)
                                  (:name "Due soon"
                                         :deadline future)
                                  (:name "Big Outcomes"
                                         :tag "bo")))
  :config
  (org-super-agenda-mode))


;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
(setq copilot-node-executable "~/.nvm/versions/node/v20.14.0/bin/node")


;; (set-frame-parameter (selected-frame) 'alpha '(92 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (92 . 90)))

(good-scroll-mode 1)
