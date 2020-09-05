(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
;(package-refresh-contents)
(require 'cl)
(defvar required-packages '(slime
			    smartparens
			    auto-complete
exec-path-from-shell imenus neotree company-jedi company flymake-python-pyflakes auto-complete smartparens slime pydoc helm-make anaconda-mode jedi elpy company-go yasnippet slime-repl-ansi-color php-mode multicolumn multi-compile helm govet go-scratch go-projectile go-playground multi-compile go-errcheck golint company-go go-mode  go-direx go-autocomplete flymake-go-staticcheck flymake-go flycheck flx-ido))

(defun packages-installed-p ()
  (loop for package in required-packages
	unless (package-installed-p package)
	do (return nil)
	finally (return t)))

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
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(package-selected-packages
   (quote
    (exec-path-from-shell imenus neotree company-jedi company flymake-python-pyflakes python-mode auto-complete smartparens slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

					;LISP
(when (packages-installed-p)
  (require 'auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  (setq-default ac-auto-start t)
  (setq-default ac-auto-show-menu t)
  (defvar *sources* (list
		     'lisp-mode
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
      '((ccl ("/opt/ccl/lx86cl64"))
	(sbcl ("/usr/bin/sbcl") :coding-system utf-8-unix)))





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


					;python else

(setq python-shell-interpreter "python3")
(setq elpy-rpc-python-command "python3")
(elpy-enable)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(defun my-merge-imenu ()
  (interactive)
  (let ((mode-imenu (imenu-default-create-index-function))
	(custom-imenu (imenu--generic-function imenu-generic-expression)))
    (append mode-imenu custom-imenu)))

(defun my-python-hooks()
  (interactive)
  (setq tab-width     4
	python-indent 4
	python-shell-interpreter "ipython"
	python-shell-interpreter-args "-i")
  (if (string-match-p "rita" (or (buffer-file-name) ""))
      (setq indent-tabs-mode t)
    (setq indent-tabs-mode nil)
    )
  (add-to-list
   'imenu-generic-expression
   '("Sections" "^#### \\[ \\(.*\\) \\]$" 1))
  (setq imenu-create-index-function 'my-merge-imenu)
  ;; pythom mode keybindings
  ;(define-key python-mode-map (kbd "M-.") 'jedi:goto-definition)
  ;(define-key python-mode-map (kbd "M-,") 'jedi:goto-definition-pop-marker)
  ;(define-key python-mode-map (kbd "M-/") 'jedi:show-doc)
  ;(define-key python-mode-map (kbd "M-?") 'helm-jedi-related-names)
  ;; end python mode keybindings

;  (eval-after-load "company"
;    '(progn
;       (unless (member 'company-jedi (car company-backends));
;	 (setq comp-back (car company-backends))
;	 (push 'company-jedi comp-back)
					;	 (setq company-backends (list comp-back)))
  )

(add-hook 'python-mode-hook 'my-python-hooks)

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
(setenv "GOPATH" "/home/user/go")
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
