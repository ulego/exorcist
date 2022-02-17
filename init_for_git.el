; remember time when
(defvar start-time (format-time-string "%a %b %d %H:%M:%S %Z %Y" (current-time)))
 ; define coding system
(cond
  ((eq system-type 'windows-nt)(setq coding-system 'windows-1251))
  ((memq system-type ('gnu/linux 'darwin))(setq coding-system 'utf-8)))
;PATH BOCK
(setenv "PATH" "")
(setenv "PATH" (concat (getenv "PATH") "\\AppData\\Roaming\\npm"))
(add-to-list 'exec-path "\\AppData\\Roaming\\npm")
(add-to-list 'exec-path "Python39\\Scripts\\")
(add-to-list 'exec-path "Python39\\")
(setenv "PATH" (mapconcat #'identity exec-path path-separator))
; map keys in org-mode
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

(require 'loadhist)
;(require 'tree-sitter)
(with-no-warnings
   (require 'cl))
(setq byte-complile-warnings '(not cl-functions))
(setq initial-scratch-message nil)
(setq inhibit-startup-screen t)

(require 'package)
(customize-set-variable 'package-archives
                        `(("melpa" . "https://melpa.org/packages/")
                          ("org" . "https://orgmode.org/elpa/")
                          ,@package-archives))
(customize-set-variable 'package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(package-initialize)
(defvar required-packages '(ac-php adaptive-wrap anaconda-mode auto-complete auto-virtualenv avy-zap berrys-theme company company-dict company-go company-jedi company-php consult csv csv-mode dired-narrow dirtree elpy emacsshot eww-lnum exec-path-from-shell expand-region exwm exwm-firefox-core exwm-float exwm-x flx-ido flycheck flymake-go flymake-go-staticcheck flymake-python-pyflakes flymake-shellcheck go-autocomplete go-direx go-errcheck go-mode go-playground go-projectile go-scratch golint govet helm helm-directory helm-file-preview helm-make helm-projectile helm-pydoc helm-swoop imenu-extra imenus jedi jedi-core jq-mode js-auto-beautify magit marginalia markdown-mode markdown-preview-eww markdown-preview-mode markdownfmt multi-compile multicolumn multiple-cursors neotree ob-restclient occur-x olivetti orderless org-babel-eval-in-repl org-roam pandoc peep-dired php-boris php-eldoc php-mode php-scratch pip-requirements popup-imenu powerline ppd-sr-speedbar prettier prettier-js proc-net projectile projectile-sift psysh py-autopep8 py-isort pydoc python-mode ranger realgud restclient selectrum simpleclip slime slime-repl-ansi-color smartparens speedbar sr-speedbar swiper swoop symon tramp-term transpose-frame tree-sitter tree-sitter-indent tree-sitter-langs treemacs treemacs-icons-dired treemacs-projectile treeview vdiff verb vertico vertigo vterm w32-ime w3m yasnippet))

(defun packages-installed-p ()
  (cl-loop for package in required-packages
	unless (package-installed-p package)
	do (cl-return nil)
	finally (cl-return t)))

(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (package required-packages)
    (unless (package-installed-p package)
            (package-install package))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(elpy-syntax-check-command "Python39\\Scripts\\flake8.exe")
 '(helm-completion-style (quote emacs))
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("org" . "https://orgmode.org/elpa/")
     ("gnu" . "https://elpa.gnu.org/packages/"))))
 '(package-enable-at-startup nil)
 '(package-selected-packages
   (quote
    (xr writegood-mode which-key w3m w32-ime vterm vlf vertigo vertico verb vdiff use-package-ensure-system-package use-package-custom-update unipunct-ng try treeview treemacs-projectile treemacs-icons-dired tree-sitter-langs tree-sitter-indent transpose-frame tramp-term tern synosaurus symon swoop suggest sudo-edit ssh-config-mode so-long smartparens smart-comment slime-repl-ansi-color simpleclip shr-tag-pre-highlight sfz-mode selectrum reverse-im restclient-test restclient-helm realgud ranger rainbow-mode rainbow-identifiers rainbow-delimiters quelpa-use-package python-pep8 python-mode pydoc py-isort py-autopep8 psysh projectile-sift proc-net prettier-js prettier ppd-sr-speedbar powerline popup-imenu pip-requirements php-scratch php-eldoc php-boris peep-dired paradox pandoc page-break-lines org-roam org-jira org-download org-bullets org-babel-eval-in-repl orderless olivetti occur-x ob-restclient neotree nameless multitran multicolumn multi-compile mood-line monokai-theme material-theme markdownfmt markdown-preview-mode markdown-preview-eww marginalia lua-mode lor-theme link-hint kubernetes kibit-helper keyfreq k8s-mode justify-kp jsonnet-mode js-import js-doc js-auto-beautify jq-mode jira-markup-mode jenkinsfile-mode jedi ivy-xref ivy-rich ivy-avy iqa ipretty info-colors imgbb imenus imenu-extra ibuffer-vc hungry-delete htmlize hl-todo highlight-sexp highlight-quoted highlight-numbers highlight-escape-sequences highlight-defined helpful helm-swoop helm-pydoc helm-projectile helm-make helm-file-preview helm-directory graphql-mode govet google-this golint go-scratch go-projectile go-playground go-errcheck go-direx go-autocomplete git-timemachine git-modes git geiser gcmh free-keys forge font-lock+ fnhh flyspell-correct-ivy flymake-shellcheck flymake-python-pyflakes flymake-go-staticcheck flymake-go flycheck-package flycheck-grammarly flycheck-golangci-lint flycheck-elsa flycheck-clj-kondo fancy-battery exwm-x exwm-float exwm-firefox-core expand-region eww-lnum eshell-toggle eshell-prompt-extras esh-help esh-autosuggest eros erefactor emamux emacsshot elsa elpy ein edit-indirect dumb-jump doom-snippets dockerfile-mode docker-compose-mode docker dirtree diredfl dired-toggle dired-rsync dired-recent dired-narrow dired-launch dired-hide-dotfiles dired-git-info diff-hl debian-el csv-mode csv counsel-world-clock counsel-web counsel-projectile copy-as-format consult company-shell company-restclient company-quickhelp company-php company-jedi company-go company-erlang company-dict coffee-mode cloud-theme clojure-snippets clj-refactor clipmon char-fold bruh browse-at-remote blacken better-defaults berrys-theme base16-theme avy-zap avy-flycheck avk-emacs-themes auto-virtualenv atomic-chrome aql-mode apt-sources-list anakondo anaconda-mode amx all-the-icons-ivy all-the-icons-dired alert ag adaptive-wrap ace-link ace-jump-buffer ac-php ac-js2)))
 '(size-indication-mode t)
 '(speedbar-default-position (quote left))
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-right-side nil))


					;LISP
(when (packages-installed-p)
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  (setq-default ac-auto-start t)
  (setq-default ac-auto-show-menu t)
  (defvar *sources* (list
		     ;'lisp-mode
		     'ac-source-semantic
		     'ac-source-functions
		     'ac-source-variables
		     'ac-source-dictionary
		     'ac-source-words-in-all-buffer
		     'ac-source-files-in-current-dir))
  (let (source)
    (dolist (source *sources*)
      (add-to-list 'ac-sources source)))
  (add-to-list 'ac-modes 'lisp-mode)

  (require 'slime)
  (require 'slime-autoloads)
  (slime-setup '(slime-asdf
		 slime-fancy
		 slime-indentation))
  (setq-default slime-net-coding-system 'utf-8-unix))
(setq-default lisp-body-indent 2)
(setq-default lisp-indent-function 'common-lisp-indent-function)
(setq slime-lisp-implementations
      '((ccl ("//lisp//ccl//wx86cl64.exe"))
	(sbcl ("//Steel Bank Common Lisp//2.0.0//sbcl.exe") :coding-system utf-8-unix)))



(setq-default lisp-body-indent 2)
(setq inhibit-startup-screen t)
(global-linum-mode t)
(global-flycheck-mode)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions nil
      kept-new-versions 2
      kept-old-versions 2
      version-control t)
(define-key (current-global-map) (kbd "<next>") nil) ; use whatever
(global-unset-key (kbd "<prior>"))
 (add-hook 'my-mode-hook 'imenu-add-menubar-index)

					;python else

;install pip3 install -U jedi virtualenv flake8
;; (setq python-shell-interpreter "c:\\Python39\\python.exe")
;; (setq elpy-rpc-python-command "c:\\Python39\\python.exe")
;; (elpy-enable)
;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

 					;GO
;;Load Go-specific language syntax
;;For gocode use https://github.com/mdempsky/gocode

;;Custom Compile Command
(defun go-mode-setup ()
  (linum-mode 1)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")
  (setq compilation-read-command nil)
  ;;  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (local-set-key (kbd "M-,") 'compile))
(add-hook 'go-mode-hook 'go-mode-setup)


(let ((path-from-shell (replace-regexp-in-string
			"[ \t\n]*$"
			""
			(shell-command-to-string "$SHELL --login  -c 'echo $PATH'"))))
  (setenv "PATH" path-from-shell)
  (setq eshell-path-env path-from-shell) ; for eshell users
  (setq exec-path (split-string path-from-shell path-separator)))
;;Load auto-complete
(ac-config-default)
(require 'auto-complete-config)
(require 'go-autocomplete)

;;Go rename

(require 'go-rename)
(setenv "GOPATH" "/go")
(setenv "GOROOT" "/usr/lib/go-1.14")
;;Configure golint
(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)



(require 'multi-compile)
(setq multi-compile-alist '(
			    (go-mode . (
					("go-build" "go build -v"
					 (locate-dominating-file buffer-file-name ".git"))
					("go-build-and-run" "go build -v && echo 'build finish' && eval ./${PWD##*/}"
					 (multi-compile-locate-file-dir ".git"))))
			    ))



;;Smaller compilation buffer
(setq compilation-window-height 14)
(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
     (save-excursion
      (let* ((w (split-window-vertically))
	     (h (window-height w)))
	(select-window w)
	(switch-to-buffer "*compilation*")
	(shrink-window (- h compilation-window-height)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)

;;Other Key bindings
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;;Compilation autoscroll
(setq compilation-scroll-output t)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'load-path "$GOPATH/src/github.com/dougm/goflymake")
(require 'company)
(require 'company-go)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
			  (set (make-local-variable 'company-backends) '(company-go))
			  (company-mode)))
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
;(py-autopep8-enable-on-save 'my-python-hooks elpy-mode)
(require 'helm-config)
(helm-mode 1)
;(helm-flx-mode 1)
(file-dependents (feature-file 'cl))
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
					;restclient
(org-babel-do-load-languages
 'org-babel-load-languages
 '((restclient . t)))
(org-babel-do-load-languages 'org-babel-load-languages
    '(
        (shell . t)
    )
			     )
(require 'csv-mode)
(setq csv-separators '(";" "  "))
;(setq peep-dired-cleanup-eagerly t)
(setq peep-dired-cleanup-on-disable t)
(setq speedbar-use-images nil)
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)
(icomplete-mode +1)
;(selectrum-mode +1)
(marginalia-mode +1)
;; Make dired open in the same window when using RET or ^
(put 'dired-find-alternate-file 'disabled nil) ; disables warning
;(require 'exwm)
;(require 'exwm-config)
;(exwm-config-default)
;(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
;(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
;; fontify code in code blocks
(if (display-graphic-p)
      (progn
		     (load-theme 'leuven t)
	(set-frame-parameter (selected-frame) 'alpha '(95 . 50))
 (add-to-list 'default-frame-alist '(alpha . (95 . 50))))
      (add-to-list 'default-frame-alist '(background-color . "ARGBBB000000"))
;      (set-background-color "ARGBBB000000")
      )

(setq frame-title-format `(,(decode-coding-string user-login-name coding-system) "@" ,(decode-coding-string system-name coding-system) "     " global-mode-string "\t\t Start: " start-time "   %f" ))
(setq org-src-fontify-natively 't)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "outline" :slant normal :weight normal :height 98 :width normal))))
 '(Man-overstrike ((t (:inherit font-lock-type-face :bold t))))
 '(Man-underline ((t (:inherit font-lock-keyword-face :underline t))))
 '(font-lock-comment-face ((t (:inherit font-lock-comment-face :italic t))))
 '(font-lock-doc-face ((t (:inherit font-lock-doc-face :italic t))))
 '(font-lock-string-face ((t (:inherit font-lock-string-face :italic t))))
 '(ivy-current-match ((t (:inherit (quote hl-line)))))
 '(mode-line ((t (:inherit default (:box (:line-width -1 :style released-button))))))
 '(woman-bold ((t (:inherit font-lock-type-face :bold t))))
 '(woman-italic ((t (:inherit font-lock-keyword-face :underline t)))))


(use-package emacs

;  :load-path "secrets"
  :init
;  (put 'narrow-to-region 'disabled nil)
;  (put 'downcase-region 'disabled nil)
 ; (fset 'x-popup-menu #'ignore)
  :custom
;  (global-display-line-numbers-mode t)
  (global-visual-line-mode t)
(helm-completion-style 'emacs)
(ispell-personal-dictionary "/.hunspell_dicname/ru_RU.dic")
(select-enable-clipboard t)
(size-indication-mode t)
(speedbar-default-position 'left)
(speedbar-show-unknown-files t)
(sr-speedbar-right-side nil)
(tool-bar-mode nil)
(tooltip-mode nil)
(truncate-lines t)
(lisp-body-indent 2)
(inhibit-startup-screen t)
(global-linum-mode t)
(global-flycheck-mode)
(backup-directory-alist `(("." . "~/.saves")))
(backup-by-copying t)
(delete-old-versions nil
      kept-new-versions 2
      kept-old-versions 2
      version-control t)
(byte-complile-warnings '(not cl-functions))
(initial-scratch-message nil)
(inhibit-startup-screen t)
 (word-wrap t)
  ;(add-to-list 'exec-path (expand-file-name "~/.local/bin"))
  (frame-resize-pixelwise t)
  ;(default-frame-alist '((menu-bar-lines 0)
  ;                       (tool-bar-lines 0)
  ;                       (vertical-scroll-bars)))

  (scroll-step 1)
  (inhibit-startup-screen t "Don't show splash screen")
;  (use-dialog-box nil "Disable dialog boxes")
  (x-gtk-use-system-tooltips nil)
;  (use-file-dialog nil)
  (enable-recursive-minibuffers t "Allow minibuffer commands in the minibuffer")
  (indent-tabs-mode nil "Spaces!")
  (tab-width 4)
  (debug-on-quit nil)
  :config
  ;; Terminal emacs doesn't have it
  (when (fboundp 'set-fontset-font)
    ;; a workaround for old charsets
    ;;(set-fontset-font "fontset-default" 'cyrillic
     ;;                 (font-spec :registry "iso10646-1" :script 'cyrillic))
    ;; TODO: is it possible to not hardcode fonts?
    (set-fontset-font t 'symbol
                      (font-spec :family
                                 (if (eq system-type 'darwin)
                                     "Apple Color Emoji"
                                   "Symbola"))
                      nil 'prepend))
  )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "JB" :slant normal :weight normal :height 101 :width normal))))
 '(Man-overstrike ((t (:inherit font-lock-type-face :bold t))))
 '(Man-underline ((t (:inherit font-lock-keyword-face :underline t))))
 '(ivy-current-match ((t (:inherit 'hl-line))))
 '(mode-line ((t (:inherit default (:box (:line-width -1 :style released-button))))))
 '(woman-bold ((t (:inherit font-lock-type-face :bold t))))
 '(woman-italic ((t (:inherit font-lock-keyword-face :underline t)))))


;; (use-package use-package-core
;;   :custom
;;   ;; (use-package-verbose t)
;;   ;; (use-package-minimum-reported-time 0.005)
;;   (use-package-enable-imenu-support t))

(use-package system-packages
  :ensure t
  :custom
  (system-packages-noconfirm t)
  (message "functions to manage system packages "))

(use-package use-package-ensure-system-package :ensure t)

(use-package quelpa
  :ensure t
  :defer t
  :custom
  (quelpa-update-melpa-p nil "Don't update the MELPA git repo."))

(use-package quelpa-use-package
  :ensure t)

(use-package use-package-custom-update
  :quelpa
  (use-package-custom-update
   :repo "a13/use-package-custom-update"
   :fetcher github
   :version original))
(use-package ispell
  :defer t
  :custom
  (ispell-local-dictionary-alist
   '(("russian"
      "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюяіїєґ’A-Za-z]"
      "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюяіїєґ’A-Za-z]"
      "[-']"  nil ("-d" "uk_UA,ru_RU,en_US") nil utf-8)))
  (ispell-program-name "hunspell")
  (ispell-dictionary "russian")
  (ispell-personal-dictionary ".hunspell_dicname/ru_RU.dic")
  (ispell-really-aspell nil)
  (ispell-really-hunspell t)
  (ispell-encoding8-command t)
  (ispell-silently-savep t))


(use-package mb-depth
  :config
  (minibuffer-depth-indicate-mode 1))

(use-package monokai-theme
  :config
  (load-theme 'monokai t))
(use-package ac-php)
(use-package adaptive-wrap)
(use-package anaconda-mode)
(use-package auto-complete)
(use-package auto-virtualenv)
(use-package avy-zap)
(use-package berrys-theme)
(use-package mb-depth
  :config
  (minibuffer-depth-indicate-mode 1))
(use-package company)
(use-package company-dict)
(use-package company-go)
(use-package company-jedi)
(use-package company-php)
(use-package consult)
(use-package csv)
(use-package csv-mode)
;;;;; company
(defun true-color-p ()
  (or
   (display-graphic-p)
   (= (tty-display-color-cells) 16777216)))
  (let* ((class '((class color) (min-colors 89)))(variant 'light) ;;              ~~ Dark ~~                              ~~ Light ~~
        ;;                                                          GUI       TER                           GUI       TER
        ;; generic
        (act1          (if (eq variant 'dark) (if (true-color-p) "#222226" "#121212") (if (true-color-p) "#e7e5eb" "#d7dfff")))
        (act2          (if (eq variant 'dark) (if (true-color-p) "#5d4d7a" "#444444") (if (true-color-p) "#d3d3e7" "#afafd7")))
        (base          (if (eq variant 'dark) (if (true-color-p) "#b2b2b2" "#b2b2b2") (if (true-color-p) "#655370" "#5f5f87")))
        (base-dim      (if (eq variant 'dark) (if (true-color-p) "#686868" "#585858") (if (true-color-p) "#a094a2" "#afafd7")))
        (bg1           (if (eq variant 'dark) (if (true-color-p) "#292b2e" "#262626") (if (true-color-p) "#fbf8ef" "#ffffff")))
        (bg2           (if (eq variant 'dark) (if (true-color-p) "#212026" "#1c1c1c") (if (true-color-p) "#efeae9" "#e4e4e4")))
        (bg3           (if (eq variant 'dark) (if (true-color-p) "#100a14" "#121212") (if (true-color-p) "#e3dedd" "#d0d0d0")))
        (bg4           (if (eq variant 'dark) (if (true-color-p) "#0a0814" "#080808") (if (true-color-p) "#d2ceda" "#bcbcbc")))
        (bg-alt        (if (eq variant 'dark) (if (true-color-p) "#42444a" "#353535") (if (true-color-p) "#efeae9" "#e4e4e4")))
        (border        (if (eq variant 'dark) (if (true-color-p) "#5d4d7a" "#111111") (if (true-color-p) "#b3b9be" "#b3b9be")))
        (cblk          (if (eq variant 'dark) (if (true-color-p) "#cbc1d5" "#b2b2b2") (if (true-color-p) "#655370" "#5f5f87")))
        (cblk-bg       (if (eq variant 'dark) (if (true-color-p) "#2f2b33" "#262626") (if (true-color-p) "#e8e3f0" "#ffffff")))
        (cblk-ln       (if (eq variant 'dark) (if (true-color-p) "#827591" "#af5faf") (if (true-color-p) "#9380b2" "#af5fdf")))
        (cblk-ln-bg    (if (eq variant 'dark) (if (true-color-p) "#373040" "#333333") (if (true-color-p) "#ddd8eb" "#dfdfff")))
        (cursor        (if (eq variant 'dark) (if (true-color-p) "#e3dedd" "#d0d0d0") (if (true-color-p) "#100a14" "#121212")))
        (const         (if (eq variant 'dark) (if (true-color-p) "#a45bad" "#d75fd7") (if (true-color-p) "#4e3163" "#8700af")))
        (comment       (if (eq variant 'dark) (if (true-color-p) "#2aa1ae" "#008787") (if (true-color-p) "#2aa1ae" "#008787")))
        (comment-light (if (eq variant 'dark) (if (true-color-p) "#2aa1ae" "#008787") (if (true-color-p) "#a49da5" "#008787")))
        (comment-bg    (if (eq variant 'dark) (if (true-color-p) "#292e34" "#262626") (if (true-color-p) "#ecf3ec" "#ffffff")))
        (comp          (if (eq variant 'dark) (if (true-color-p) "#c56ec3" "#d75fd7") (if (true-color-p) "#6c4173" "#8700af")))
        (err           (if (eq variant 'dark) (if (true-color-p) "#e0211d" "#e0211d") (if (true-color-p) "#e0211d" "#e0211d")))
        (func          (if (eq variant 'dark) (if (true-color-p) "#bc6ec5" "#d75fd7") (if (true-color-p) "#6c3163" "#8700af")))
        (head1         (if (eq variant 'dark) (if (true-color-p) "#4f97d7" "#268bd2") (if (true-color-p) "#3a81c3" "#268bd2")))
        (head1-bg      (if (eq variant 'dark) (if (true-color-p) "#293239" "#262626") (if (true-color-p) "#edf1ed" "#ffffff")))
        (head2         (if (eq variant 'dark) (if (true-color-p) "#2d9574" "#2aa198") (if (true-color-p) "#2d9574" "#2aa198")))
        (head2-bg      (if (eq variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff")))
        (head3         (if (eq variant 'dark) (if (true-color-p) "#67b11d" "#67b11d") (if (true-color-p) "#67b11d" "#5faf00")))
        (head3-bg      (if (eq variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff")))
        (head4         (if (eq variant 'dark) (if (true-color-p) "#b1951d" "#875f00") (if (true-color-p) "#b1951d" "#875f00")))
        (head4-bg      (if (eq variant 'dark) (if (true-color-p) "#32322c" "#262626") (if (true-color-p) "#f6f1e1" "#ffffff")))
        (highlight     (if (eq variant 'dark) (if (true-color-p) "#444155" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
        (highlight-dim (if (eq variant 'dark) (if (true-color-p) "#3b314d" "#444444") (if (true-color-p) "#e7e7fc" "#d7d7ff")))
        (keyword       (if (eq variant 'dark) (if (true-color-p) "#4f97d7" "#268bd2") (if (true-color-p) "#3a81c3" "#268bd2")))
        (lnum          (if (eq variant 'dark) (if (true-color-p) "#44505c" "#444444") (if (true-color-p) "#a8a8bf" "#af87af")))
        (mat           (if (eq variant 'dark) (if (true-color-p) "#86dc2f" "#86dc2f") (if (true-color-p) "#ba2f59" "#af005f")))
        (meta          (if (eq variant 'dark) (if (true-color-p) "#9f8766" "#af875f") (if (true-color-p) "#da8b55" "#df5f5f")))
        (str           (if (eq variant 'dark) (if (true-color-p) "#2d9574" "#2aa198") (if (true-color-p) "#2d9574" "#2aa198")))
        (suc           (if (eq variant 'dark) (if (true-color-p) "#86dc2f" "#86dc2f") (if (true-color-p) "#42ae2c" "#00af00")))
        (ttip          (if (eq variant 'dark) (if (true-color-p) "#9a9aba" "#888888") (if (true-color-p) "#8c799f" "#5f5f87")))
        (ttip-sl       (if (eq variant 'dark) (if (true-color-p) "#5e5079" "#333333") (if (true-color-p) "#c8c6dd" "#afafff")))
        (ttip-bg       (if (eq variant 'dark) (if (true-color-p) "#34323e" "#444444") (if (true-color-p) "#e2e0ea" "#dfdfff")))
        (type          (if (eq variant 'dark) (if (true-color-p) "#ce537a" "#df005f") (if (true-color-p) "#ba2f59" "#af005f")))
        (var           (if (eq variant 'dark) (if (true-color-p) "#7590db" "#8787d7") (if (true-color-p) "#715ab1" "#af5fd7")))
        (war           (if (eq variant 'dark) (if (true-color-p) "#dc752f" "#dc752f") (if (true-color-p) "#dc752f" "#dc752f")))

        ;; colors
        (aqua          (if (eq variant 'dark) (if (true-color-p) "#2d9574" "#2aa198") (if (true-color-p) "#2d9574" "#2aa198")))
        (aqua-bg       (if (eq variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff")))
        (green         (if (eq variant 'dark) (if (true-color-p) "#67b11d" "#67b11d") (if (true-color-p) "#67b11d" "#5faf00")))
        (green-bg      (if (eq variant 'dark) (if (true-color-p) "#293235" "#262626") (if (true-color-p) "#edf2e9" "#ffffff")))
        (green-bg-s    (if (eq variant 'dark) (if (true-color-p) "#29422d" "#262626") (if (true-color-p) "#dae6d0" "#ffffff")))
        (cyan          (if (eq variant 'dark) (if (true-color-p) "#28def0" "#00ffff") (if (true-color-p) "#21b8c7" "#008080")))
        (red           (if (eq variant 'dark) (if (true-color-p) "#f2241f" "#d70000") (if (true-color-p) "#f2241f" "#d70008")))
        (red-bg        (if (eq variant 'dark) (if (true-color-p) "#3c2a2c" "#262626") (if (true-color-p) "#faede4" "#ffffff")))
        (red-bg-s      (if (eq variant 'dark) (if (true-color-p) "#512e31" "#262626") (if (true-color-p) "#eed9d2" "#ffffff")))
        (blue          (if (eq variant 'dark) (if (true-color-p) "#4f97d7" "#268bd2") (if (true-color-p) "#3a81c3" "#268bd2")))
        (blue-bg       (if (eq variant 'dark) (if (true-color-p) "#293239" "#262626") (if (true-color-p) "#edf1ed" "#d7d7ff")))
        (blue-bg-s     (if (eq variant 'dark) (if (true-color-p) "#2d4252" "#262626") (if (true-color-p) "#d1dcdf" "#d7d7ff")))
        (magenta       (if (eq variant 'dark) (if (true-color-p) "#a31db1" "#af00df") (if (true-color-p) "#a31db1" "#800080")))
        (yellow        (if (eq variant 'dark) (if (true-color-p) "#b1951d" "#875f00") (if (true-color-p) "#b1951d" "#875f00")))
        (yellow-bg     (if (eq variant 'dark) (if (true-color-p) "#32322c" "#262626") (if (true-color-p) "#f6f1e1" "#ffffff"))))

(custom-set-faces
     `(company-echo-common ((,class (:background ,base :foreground ,bg1))))
     `(company-preview ((,class (:background ,ttip-bg :foreground ,ttip))))
     `(company-preview-common ((,class (:background ,ttip-bg :foreground ,base))))
     `(company-preview-search ((,class (:inherit match))))
     `(company-scrollbar-bg ((,class (:background ,bg2))))
     `(company-scrollbar-fg ((,class (:background ,act2))))
     `(company-template-field ((,class (:inherit region))))
     `(company-tooltip ((,class (:background ,ttip-bg :foreground ,ttip))))
     `(company-tooltip-annotation ((,class (:foreground ,type))))
     `(company-tooltip-common ((,class (:background ,ttip-bg :foreground ,keyword))))
     `(company-tooltip-common-selection ((,class (:foreground ,keyword))))
     `(company-tooltip-mouse ((,class (:inherit highlight))))
     `(company-tooltip-search ((,class (:inherit match))))
     `(company-tooltip-selection ((,class (:background ,ttip-sl :foreground ,base))))))

;; (use-package color
;;   :ensure t
;;   :config
;; (let ((bg (face-attribute 'default :background)))
;;     (custom-set-faces
;;      `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 10)))))
;;      `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 1)))))
;;      `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;      `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;      `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))))
(use-package dired-narrow)
(use-package dirtree)
                                        ;(use-package elpy)
;install elpy from git
(add-to-list 'load-path "\\.emacs.d\\elpa\\elpy")
(load "elpy")
(load "elpy-rpc")
(load "elpy-shell")
(load "elpy-profile")
(load "elpy-refactor")
(load "elpy-django")
(use-package emacsshot)
(use-package eww-lnum)
(use-package exec-path-from-shell)
(use-package expand-region)
(use-package exwm)
(use-package exwm-firefox-core)
(use-package exwm-float)
(use-package exwm-x)
(use-package fill-column-indicator)
(use-package flx-ido)
(use-package flycheck)
(use-package flymake-go)
(use-package flymake-go-staticcheck)
(use-package flymake-python-pyflakes)
(use-package flymake-shellcheck)
(use-package geben)
(use-package geben-helm-projectile)
(use-package go-autocomplete)
(use-package go-direx)
(use-package go-errcheck)
(use-package go-mode)
(use-package go-playground)
(use-package go-projectile)
(use-package go-scratch)
(use-package golint)
(use-package govet)
(use-package gcmh
  :ensure t
  :demand t
  :config
  (gcmh-mode 1)
  (message "the Garbage Collector Magic Hack "))
(use-package helm :ensure t :init (helm-mode))
(use-package helm-directory)
(use-package helm-file-preview)
(use-package helm-make)
(use-package helm-projectile)
(use-package helm-pydoc)
(use-package helm-swoop)
(use-package ibuffer
  :bind
  ([remap list-buffers] . ibuffer))
(use-package imenu-extra)
(use-package imenus)
(use-package jedi)
(use-package jedi-core)
(use-package jq-mode)
(use-package js-auto-beautify)
;(use-package magit)
(use-package marginalia
  :init
  (marginalia-mode))
(use-package markdown-mode)
(use-package markdown-preview-eww)
(use-package markdown-preview-mode)
(use-package markdownfmt)
(use-package multi-compile)
(use-package multicolumn)
(use-package multiple-cursors)
(use-package neotree)
(use-package net-utils
  :ensure-system-package traceroute
  :bind
  (:map mode-specific-map
        :prefix-map net-utils-prefix-map
        :prefix "n"
        ("p" . ping)
        ("i" . ifconfig)
        ("w" . iwconfig)
        ("n" . netstat)
        ("p" . ping)
        ("a" . arp)
        ("r" . route)
        ("h" . nslookup-host)
        ("d" . dig)
        ("s" . smbclient)
        ("t" . traceroute)))
(use-package google-this
  :defer 0.1
  :ensure t
  :bind
  (:map mode-specific-map
        ("g" . #'google-this-mode-submap)))

(use-package ob-restclient)
(use-package occur-x)
(use-package olivetti)
(use-package orderless)
(use-package org-babel-eval-in-repl)
(use-package org-ref)
(use-package org-ref-prettify)
;(use-package org-roam)
(use-package pandoc)
(use-package pdf-tools
  :load-path "site-lisp/pdf-tools/lisp"
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install :no-query))
(use-package peep-dired)
(use-package php-boris)
(use-package php-mode)
(use-package php-scratch)
(use-package pip-requirements)
(use-package popup-imenu)
(use-package powerline)
(use-package ppd-sr-speedbar)
(use-package prettier)
(use-package prettier-js)
(use-package proc-net)
(use-package projectile)
(use-package projectile-sift)
(use-package psysh)
(use-package py-autopep8)
(use-package py-isort)
(use-package pydoc)
;python -m  venv c:/lisp/.emacs.d/elpy/rpc-venv/ --upgrade
(setq python-shell-interpreter "python")
(setq elpy-rpc-python-command "\\Python39\\python.exe")
                                        ;(setq shell-file-name "cmd.exe")
;(setenv "WORKON_HOME" "c:\\lisp\\.emacs.d\\elpy")  ;"c:\\lisp\\envs")
;(pyvenv-mode 1)
(pyvenv-activate "\\lisp\\.emacs.d\\elpy\\rpc-venv")
(elpy-enable)
(use-package python-mode
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("\\Python39\\python.exe" . python-mode)
  :config
 ;            (python-shell-interpreter "\\Python39\\python.exe")
             
 ;           (elpy-rpc-python-command "\\Python39\\python.exe")
             ;(setq shell-file-name "cmd.exe")
             (setenv "WORKON_HOME" "\\.emacs.d\\elpy")  ;"c:\\lisp\\envs")
(pyvenv-mode 1)
(pyvenv-activate "rpc-venv")
  (elpy-enable)
  (when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
  )
(use-package ranger)
(use-package realgud)
(use-package restclient)
(use-package selectrum)
(use-package simpleclip)
;; Integrating SLIME with EMACS for Common Lisp
(setq slime-lisp-implementations
      '((ccl ("//lisp//ccl//wx86cl64.exe"))
	(sbcl ("//Steel Bank Common Lisp//2.0.0//sbcl.exe") :coding-system utf-8-unix))
      )
(use-package slime
  :ensure t
  :disabled
  :config
  (setq
        slime-lisp-implementations
        lisp-indent-function 'common-lisp-indent-function
        slime-complete-symbol-function 'slime-fuzzy-complete-symbol
        slime-startup-animation nil)
  (slime-setup '(slime-fancy)))
(use-package slime-repl-ansi-color)
(use-package smartparens)
(use-package speedbar)
(use-package sr-speedbar)
(use-package swiper :ensure t)
(use-package swoop)
(use-package symon)
(use-package tramp-term)
(use-package transpose-frame)
;; (use-package treemacs)
;; (use-package treemacs-icons-dired)
;; (use-package treemacs-projectile)
(use-package treeview)
(use-package vdiff)
(use-package verb)
(use-package vertico
  :config
  (vertico-mode 1))
(use-package vertigo)
(use-package visible-mark)
(use-package visual-fill-column)
;(use-package vterm)
(use-package w32-ime)
;(use-package w3m)
(use-package yasnippet)

(use-package man
  :defer t
  :custom
  (Man-notify-method 'pushy "show manpage HERE")
  :custom-face
  (Man-overstrike ((t (:inherit font-lock-type-face :bold t))))
  (Man-underline ((t (:inherit font-lock-keyword-face :underline t)))))

(use-package woman
  :defer t
  :custom-face
  (woman-bold ((t (:inherit font-lock-type-face :bold t))))
  (woman-italic ((t (:inherit font-lock-keyword-face :underline t)))))
(use-package info-colors
  :ensure t
  :hook
  (Info-selection #'info-colors-fontify-node))
(use-package ag
  :ensure t
  :defer t
  :ensure-system-package (ag . silversearcher-ag)
  :custom
  (ag-highlight-search t "Highlight the current search term."))
(use-package sudo-edit
  :ensure t
  :config (sudo-edit-indicator-mode)
  :bind (:map ctl-x-map
              ("M-s" . sudo-edit)))

;; (use-package exec-path-from-shell
;;   :ensure t
;;   :defer 0.1
;;   :config
;;   (exec-path-from-shell-initialize))

(use-package xr
  :ensure t
  :defer t)

;; (use-package em-smart
;;   :defer t
;;   :config
;;   (eshell-smart-initialize)
;;   :custom
;;   (eshell-where-to-jump 'begin)
;;   (eshell-review-quick-commands nil)
;;   (eshell-smart-space-goes-to-end t))

(use-package esh-help
  :ensure t
  :defer t
  :config
  (setup-esh-help-eldoc))
(use-package esh-autosuggest
  :ensure t
  :hook (eshell-mode . esh-autosuggest-mode))


(use-package eshell-prompt-extras
  :ensure t
  :after (eshell esh-opt)
  :custom
  (eshell-prompt-function #'epe-theme-dakrone))

(use-package eshell-toggle
  :ensure t
  :after projectile
  :custom
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  :bind
  ("M-`" . eshell-toggle))


(use-package dired-toggle
  :ensure t
  :defer t)

(use-package dired-hide-dotfiles
  :ensure t
  :bind
  (:map dired-mode-map
        ("." . dired-hide-dotfiles-mode))
  :hook
  (dired-mode . dired-hide-dotfiles-mode))

(use-package diredfl
  :ensure t
  :hook
  (dired-mode . diredfl-mode))

(use-package async
  :ensure t
  :defer t
  :custom
  (dired-async-mode 1))
(use-package dired-rsync
  :ensure t
  :bind
  (:map dired-mode-map
        ("r" . dired-rsync)))

(use-package dired-launch
  :ensure t
  :hook
  (dired-mode . dired-launch-mode))

(use-package dired-git-info
  :ensure t
  :bind
  (:map dired-mode-map
        (")" . dired-git-info-mode)))

(use-package dired-recent
  :ensure t
  :bind
  (:map
   dired-recent-mode-map ("C-x C-d" . nil))
  :config
  (dired-recent-mode 1))
(use-package time
  :defer t
  :custom
  (display-time-default-load-average nil)
  (display-time-24hr-format t)
  (display-time-mode t))

(use-package fancy-battery
  :ensure t
  :hook
  (after-init . fancy-battery-mode))

(use-package olivetti
  :defer t
  :ensure t
  :custom
  (olivetti-body-width 95))

(use-package font-lock+
  :defer t
  :quelpa
  (font-lock+ :repo "emacsmirror/font-lock-plus" :fetcher github))
(use-package all-the-icons
  :ensure t
  :defer t
  :config
  (setq all-the-icons-mode-icon-alist
        `(,@all-the-icons-mode-icon-alist
          (package-menu-mode all-the-icons-octicon "package" :v-adjust 0.0)
          (jabber-chat-mode all-the-icons-material "chat" :v-adjust 0.0)
          (jabber-roster-mode all-the-icons-material "contacts" :v-adjust 0.0)
          (telega-chat-mode all-the-icons-fileicon "telegram" :v-adjust 0.0
                            :face all-the-icons-blue-alt)
          (telega-root-mode all-the-icons-material "contacts" :v-adjust 0.0))))

(use-package all-the-icons-dired
  :ensure t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ivy
  :defer t
  :ensure t
  :after ivy
  :custom
  (all-the-icons-ivy-buffer-commands '() "Don't use for buffers.")
  :config
  (all-the-icons-ivy-setup))

(use-package mood-line
  :ensure t
  :custom-face
  (mode-line ((t (:inherit default (:box (:line-width -1 :style released-button))))))
  :hook
  (after-init . mood-line-mode))
(use-package amx :ensure t :defer t)

(use-package ivy
  :ensure t
  :custom
  ;; (ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
  (ivy-count-format "%d/%d " "Show anzu-like counter")
  (ivy-use-selectable-prompt t "Make the prompt line selectable")
  :custom-face
  (ivy-current-match ((t (:inherit 'hl-line))))
  :bind
  (:map mode-specific-map
        ("C-r" . ivy-resume))
  :config
  (ivy-mode t))

(use-package ivy-xref
  :ensure t
  :defer t
  :custom
  (xref-show-xrefs-function #'ivy-xref-show-xrefs "Use Ivy to show xrefs"))

(use-package counsel
  :ensure t
  :bind
  (([remap menu-bar-open] . counsel-tmm)
   ([remap insert-char] . counsel-unicode-char)
   ([remap isearch-forward] . counsel-grep-or-swiper)
   :map mode-specific-map
   :prefix-map counsel-prefix-map
   :prefix "c"
   ("a" . counsel-apropos)
   ("b" . counsel-bookmark)
   ("B" . counsel-bookmarked-directory)
   ("c w" . counsel-colors-web)
   ("c e" . counsel-colors-emacs)
   ("d" . counsel-dired-jump)
   ("f" . counsel-file-jump)
   ("F" . counsel-faces)
   ("g" . counsel-org-goto)
   ("h" . counsel-command-history)
   ("H" . counsel-minibuffer-history)
   ("i" . counsel-imenu)
   ("j" . counsel-find-symbol)
   ("l" . counsel-locate)
   ("L" . counsel-find-library)
   ("m" . counsel-mark-ring)
   ("o" . counsel-outline)
   ("O" . counsel-find-file-extern)
   ("p" . counsel-package)
   ("r" . counsel-recentf)
   ("s g" . counsel-grep)
   ("s r" . counsel-rg)
   ("s s" . counsel-ag)
   ("t" . counsel-org-tag)
   ("v" . counsel-set-variable)
   ("w" . counsel-wmctrl)
   :map help-map
   ("F" . counsel-describe-face))
  :custom
  (counsel-grep-base-command
   "rg -i -M 120 --no-heading --line-number --color never %s %s")
  (counsel-search-engines-alist
   '((google
      "http://suggestqueries.google.com/complete/search"
      "https://www.google.com/search?q="
      counsel--search-request-data-google)
     (ddg
      "https://duckduckgo.com/ac/"
      "https://duckduckgo.com/html/?q="
      counsel--search-request-data-ddg)))
  :init
  (counsel-mode))


(if (display-graphic-p)
      (progn
		     (load-theme 'leuven t)
	(set-frame-parameter (selected-frame) 'alpha '(95 . 50))
 (add-to-list 'default-frame-alist '(alpha . (95 . 50))))
      (add-to-list 'default-frame-alist '(background-color . "ARGBBB000000"))
;      (set-background-color "ARGBBB000000")
      )
(setq debug-on-error nil)
(setq debug-on-quit nil)

;(treemacs-git-mode -1)
;;; .emacs ends here
