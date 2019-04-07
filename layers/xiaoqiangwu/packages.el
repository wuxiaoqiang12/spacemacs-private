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
    youdao-dictionary)
)

(defun xiaoqiangwu/post-init-company()
  (setq company-minimum-prefix-length 1)
  (global-company-mode))

(defun xiaoqiangwu/post-init-hungry-delete()
  (global-hungry-delete-mode))

(defun xiaoqiangwu/post-init-flycheck()
  (add-hook 'coq-mode-hook 'flycheck-mode))

(defun xiaoqiangwu/post-init-youdao-dictionary()
  (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point))

(defun xiaoqiangwu/post-init-org()

  (setq org-agenda-files '("~/org"))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
  
  (setq org-capture-templates
        `(("i" "inbox" entry (file "~/org/gtd/inbox.org")
           "* TODO %?")
          ("p" "paper" entry (file "~/org/papers/papers.org")
           "* TODO %(jethro/trim-citation-title \"%:title\")\n%a" :immediate-finish t)
          ("e" "email" entry (file+headline "~/org/gtd/emails.org" "Emails")
           "* TODO [#A] Reply: %a :@home:@school:" :immediate-finish t)
          ("l" "link" entry (file "~/org/gtd/inbox.org")
           "* TODO %(org-cliplink-capture)" :immediate-finish t)
          ("z" "elfeed-link" entry (file "~/org/gtd/inbox.org")
           "* TODO %a\n" :immediate-finish t)
          ("w" "Weekly Review" entry (file+olp+datetree "~/org/gtd/reviews.org")
           (file "~/org/gtd/templates/weekly_review.org"))
          ("s" "Snippet" entry (file "~/org/deft/capture.org")
           "* Snippet %<%Y-%m-%d %H:%M>\n%?")))

  ;;An entry without a cookie is treated just like priority ' B '.
  ;;So when create new task, they are default 重要且紧急
  (setq org-agenda-custom-commands
        '(
          ("w" . "任务安排")
          ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
          ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
          ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
          ("b" "Blog" tags-todo "BLOG")
          ("p" . "项目安排")
          ("pw" tags-todo "PROJECT+WORK+CATEGORY=\"cocos2d-x\"")
          ("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"zilongshanren\"")
          ("W" "Weekly Review"
           ((stuck "") ;; review stuck projects as designated by org-stuck-projects
            (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
            ))))
  )
;;; packages.el ends here
