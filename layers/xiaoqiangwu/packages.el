;;; packages.el --- xiaoqiangwu layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: jon <jon@jon-lab>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `xiaoqiangwu-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `xiaoqiangwu/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `xiaoqiangwu/pre-init-PACKAGE' and/or
;;   `xiaoqiangwu/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst xiaoqiangwu-packages
  '(company
    hungry-delete
    flycheck
    org
    abbrev
    auctex
    ;; latex
    ;;ocaml
    ;;gtags
	dired
    buffer-move
	treemacs-icons-dired
    ;; leetcode
    youdao-dictionary
    exec-path-from-shell)
)

;;(defun xiaoqiangwu/post-init-gtags()
  ;;(ggtags-mode))

(defun xiaoqiangwu/post-init-dired()
  (add-hook 'dired-mode-hook 'treemacs-icons-dired-mode))

(defun xiaoqiangwu/init-treemacs-icons-dired())

;; (defun xiaoqiangwu/post-init-leetcode()
;;   (setq leetcode-prefer-language "python3"))
(defun xiaoqiangwu/init-buffer-move()
  (use-package buffer-move
     :defer t
     :init
     (spacemacs/set-leader-keys "bh" 'buf-move-left)
     (spacemacs/set-leader-keys "bj" 'buf-move-down)
     (spacemacs/set-leader-keys "bk" 'buf-move-up)
     (spacemacs/set-leader-keys "bl" 'buf-move-right))
  )

;; (defun xiaoqiangwu/init-flycheck-ocaml()
;;   (add-hook 'ocaml-mode-local-vars-hook 'flycheck-mode))

(defun xiaoqiangwu/init-exec-path-from-shell()
  (exec-path-from-shell-initialize))

(defun xiaoqiangwu/post-init-company()
  (setq company-minimum-prefix-length 2)
  (global-company-mode)
  ;;(spacemacs|diminish company-mode "Ⓒ" "C")
  )

;; (defun xiaoqiangwu/post-init-org()
;;   (add-hook 'org-mode-hook 'auto-fill-mode)
;;   (setq org-startup-indented t)
;;   )

(defun xiaoqiangwu/post-init-auctex()
  (add-hook 'LaTeX-mode-hook 'outline-minor-mode)
  (add-hook 'LaTeX-mode-hook 'outline-hide-body)
  )

;; (defun xiaoqiangwu/post-init-latex()
;;   (setq TeX-global-PDF-mode nil)
;;   )

(defun xiaoqiangwu/post-init-hungry-delete()
  (global-hungry-delete-mode)
  ;;(spacemacs|diminish hungry-delete-mode "Ⓗ" "H")
  )

(defun xiaoqiangwu/post-init-flycheck()
  (add-hook 'coq-mode-hook 'flycheck-mode))

(defun xiaoqiangwu/post-init-abbrev()
  (use-package abbrev
    :diminish abbrev-mode
    :config
    (if (file-exists-p abbrev-file-name)
        (quietly-read-abbrev-file))))

(defun xiaoqiangwu/init-youdao-dictionary()
  (use-package youdao-dictionary
    :defer t
    :init
    (spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point-tooltip))
  ;; (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)
  )

(defun xiaoqiangwu/post-init-org()

   (add-hook 'org-mode-hook 'auto-fill-mode)
   (setq org-startup-indented t)
   (add-hook 'org-mode-hook
             (lambda () (setq truncate-lines nil)))

   ;; (setcar (nthcdr 4 org-emphasis-regexp-components) 20)
   ;; (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
   )
;;   (setq org-agenda-files '("~/Dropbox/org/gtd"))

;;   (setq org-todo-keywords
;;         '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
;;           (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))

;;   (setq org-capture-templates
;;         `(("i" "inbox" entry (file "~/Dropbox/org/gtd/inbox.org")
;;            "* TODO %?")
;;           ("b" "Billing" plain
;;            (file+function "~/Dropbox/org/billing.org" find-month-tree)
;;            " | %U | %^{Type} | %^{Description} | %^{Amount} |" :kill-buffer t)
;;           ("c" "course" entry (file "~/Dropbox/org/gtd/course.org")
;;            "* TODO %?")
;;           ("r" "research" entry (file "~/Dropbox/org/gtd/research.org")
;;            "* TODO %?")
;;           ("l" "leisure" entry (file "~/Dropbox/org/gtd/leisure.org")
;;            "* TODO %?")
;;           ("t" "tricks" entry (file "~/Dropbox/org/gtd/tricks.org")
;; 	         "* DONE %?")
;;           ("p" "paper" entry (file "~/Dropbox/org/papers/papers.org")
;;            "* TODO %(jethro/trim-citation-title \"%:title\")\n%a" :immediate-finish t)
;;           ("e" "email" entry (file+headline "~/Dropbox/org/gtd/emails.org" "Emails")
;;            "* TODO [#A] Reply: %a :@home:@school:" :immediate-finish t)
;;           ("a" "link" entry (file "~/Dropbox/org/gtd/inbox.org")
;;            "* TODO %(org-cliplink-capture)" :immediate-finish t)
;;           ;;("z" "elfeed-link" entry (file "~/Dropbox/org/gtd/inbox.org")
;;           ;; "* TODO %a\n" :immediate-finish t)
;;           ("w" "Weekly Review" entry (file+olp+datetree "~/Dropbox/org/gtd/reviews.org")
;;            (file "~/org/gtd/templates/weekly_review.org"))
;;           ;;("s" "Snippet" entry (file "~/Dropbox/org/deft/capture.org")
;;           ;;"* Snippet %<%Y-%m-%d %H:%M>\n%?")
;;           ))

;; ;;   ;;An entry without a cookie is treated just like priority ' B '.
;; ;;   ;;So when create new task, they are default 重要且紧急
;; ;;   (setq org-agenda-custom-commands
;; ;;         '(
;; ;;           ("w" . "任务安排")
;; ;;           ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
;; ;;           ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
;; ;;           ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
;; ;;           ("b" "Blog" tags-todo "BLOG")
;; ;;           ("p" . "项目安排")
;; ;;           ("pw" tags-todo "PROJECT+WORK+CATEGORY=\"cocos2d-x\"")
;; ;;           ("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"zilongshanren\"")
;; ;;           ("W" "Weekly Review"
;; ;;            ((stuck "") ;; review stuck projects as designated by org-stuck-projects
;; ;;             (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
;; ;;             ))))
;;   )


;; DO NOT NEED PYIM AGAIN
;; (defun xiaoqiangwu/post-init-pyim()
;;   ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
;;   (use-package pyim-basedict
;;     :ensure nil
;;     :config (pyim-basedict-enable))

;;   (setq default-input-method "pyim")
;;   ;;(spacemacs|diminish pyim-isearch-mode "Ⓘ" "I")
;;   ;; 我使用全拼
;;   (setq pyim-default-scheme 'quanpin)

;;   ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
;;   ;; 我自己使用的中英文动态切换规则是：
;;   ;; 1. 光标只有在注释里面时，才可以输入中文。
;;   ;; 2. 光标前是汉字字符时，才能输入中文。
;;   ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
;;   (setq-default pyim-english-input-switch-functions
;;                 '(pyim-probe-dynamic-english
;;                   pyim-probe-isearch-mode
;;                   pyim-probe-program-mode
;;                   pyim-probe-org-structure-template))

;;   (setq-default pyim-punctuation-half-width-functions
;;                 '(pyim-probe-punctuation-line-beginning
;;                   pyim-probe-punctuation-after-punctuation))

;;   ;; 开启拼音搜索功能
;;   (pyim-isearch-mode 1)

;;   ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
;;   ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
;;   ;; 手动安装 posframe 包。
;;   (setq pyim-page-tooltip 'popup)

;;   ;; 选词框显示5个候选词
;;   (setq pyim-page-length 5)

;;   ;; :bind
;;   ;; (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
;;   ;;  ("C-;" . pyim-delete-word-from-personal-buffer))
;;   )


;;; packages.el ends here
