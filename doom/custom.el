(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" default))
 '(org-agenda-files
   '("~/org/2020-11-17.org" "~/org/birthdays.org" "/home/em/org/calendar.org" "/home/em/org/collection.org" "/home/em/org/gtd.org" "/home/em/org/linked.org" "/home/em/org/mentorship.org" "/home/em/org/orgmode.org" "/home/em/org/people.org" "/home/em/org/pomodoro.org" "/home/em/org/projects.org" "/home/em/org/reading.org" "/home/em/org/vc-ref.org"))
 '(org-journal-date-format "%A, %d %B %Y")
 '(org-journal-dir "~/org/journal/")
 '(org-roam-server-authenticate nil)
 '(org-roam-server-export-inline-images t)
 '(org-roam-server-host "127.0.0.1")
 '(org-roam-server-network-arrows nil)
 '(org-roam-server-network-label-truncate t)
 '(org-roam-server-network-label-truncate-length 60)
 '(org-roam-server-network-label-wrap-length 20)
 '(org-roam-server-network-poll t)
 '(org-roam-server-port 8080)
 '(org-roam-server-serve-files nil)
 '(org-roam-server-served-file-extensions '("pdf" "mp4" "ogv"))
 '(package-selected-packages
   '(org-wild-notifier hackernews company-org-roam org-superstar all-the-icons-dired all-the-icons-ivy-rich unicode-emoticons universal-emotions-emoticons ereader hnreader nov calibredb org-roam-server projectile-git-autofetch org-pomodoro org-roam)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-c C-'") 'org-edit-src-code)
(global-set-key (kbd "C-!") (lambda() (interactive)(find-file "~/org/collection.org")))
(global-set-key (kbd "C-/") 'comment-line)
(map! :leader
      :prefix "w"
        :desc "Find window" "f" #'ace-window)

(setq org-file-apps
    (quote
        ((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . "/usr/bin/microsoft-edge-dev %s")
        ("\\.pdf\\'" . default))))

(require 'org-pomodoro)
(require 'org-superstar)
(require 'org-roam)
(after! org
  (require 'git-auto-commit-mode)
  (run-with-idle-timer 20 t (lambda() (org-agenda nil "a")))
  (setq org-todo-keyword-faces
        '(("TODO" . org-warning)
          ("STARTED" . "yellow")
          ("REVIEW" . "pink")
          ("CANCELED" . (:foreground "blue" :weight bold))))
  (setq org-todo-keywords
        '(
          (sequence "TODO( )" "NEXT(n)" "PROJ(p)" "LATER(l)" "WAIT(w)" "REVIEW(r)"  "|"  "DONE(X)" "CANCELED(c)" "DELEGATED(e)")
          )
        )
  (setq-default gac-automatically-push-p t)
  (add-to-list 'org-capture-templates
               '("r"
                 "Book"
                 entry
                 (file "~/org/reading.org")
                 "* %^{TITLE}\n:PROPERTIES:\n:ADDED: %<[%Y-%02m-%02d]>\n:END:%^{AUTHOR}p\n%?" :empty-lines 1))
  (setq org-ellipsis " ")
  (setq org-superstar-headline-bullets-list '("" "" "" "▷", "", ""))
  ;; This configuration is used to change the size of the different header levels
  (dolist
      (face '(
              (org-level-1 . 1.3)
              (org-level-2 . 1.2)
              (org-level-3 . 1.1)
              (org-level-4 . 1.0)
              (org-level-5 . 1.1)
              (org-level-6 . 1.1)
              (org-level-7 . 1.1)
              (org-level-8 . 1.1)
              )
            )
    ;; The method called to set the header size (face variable)
    (set-face-attribute (car face) nil :font "CaskaydiaCove Nerd Font Book" :weight 'regular :height (cdr face))
    )

  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
 (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
 ;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
 (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
 (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
 (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
 (setq org-roam-directory "~/org")
 (setq org-roam-dailies-directory "~/org")
 (setq org-roam-dailies-capture-templates
       '(
         ("d" "Bullet" entry
          #'org-roam-capture--get-point
          "* %?"
          :file-name "~/org/%<%Y-%m-%d>"
          )
         ("t" "todo" entry
          #'org-roam-capture--get-point
          "* TODO %?"
          :file-name "~/org/%<%Y-%m-%d>"
          )
         ("l" "later item" entry
          #'org-roam-capture--get-point
          "* LATER %?"
          :file-name "~/org/%<%Y-%m-%d>"
          )
         )
       )
 (setq org-tag-alist
  '((:startgroup)
     ; Put mutually exclusive tags here
     (:endgroup)
     ("@errand" . ?E)
     ("@laptop" . ?H)
     ("@tablet" . ?H)
     ("@work" . ?W)
     ("agenda" . ?a)
     ("planning" . ?p)
     ("publish" . ?P)
     ("batch" . ?b)
     ("note" . ?n)
     ("idea" . ?i)))
 ;; Configure custom agenda views
 (setq org-agenda-custom-commands
       '(("d" "Dashboard"
          ((agenda "" ((org-deadline-warning-days 7)))
           (todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))
           (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))
         ("n" "Next Tasks"
          ((todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))))
         ("W" "Work Tasks" tags-todo "+work-email")
         ;; Low-effort next actions
         ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
          ((org-agenda-overriding-header "Low Effort Tasks")
           (org-agenda-max-todos 20) (org-agenda-files org-agenda-files)))
         ("w" "Workflow Status"
          ((todo "WAIT"
                 ((org-agenda-overriding-header "Waiting on External")
                  (org-agenda-files org-agenda-files)))
           (todo "REVIEW"
                 ((org-agenda-overriding-header "In Review")
                  (org-agenda-files org-agenda-files)))
           (todo "PLAN"
                 ((org-agenda-overriding-header "In Planning")
                  (org-agenda-todo-list-sublevels nil)
                  (org-agenda-files org-agenda-files)))
           (todo "BACKLOG"
                 ((org-agenda-overriding-header "Project Backlog")
                  (org-agenda-todo-list-sublevels nil)
                  (org-agenda-files org-agenda-files)))
           (todo "READY"
                 ((org-agenda-overriding-header "Ready for Work")
                  (org-agenda-files org-agenda-files)))
           (todo "ACTIVE"
                 ((org-agenda-overriding-header "Active Projects")
                  (org-agenda-files org-agenda-files)))
           (todo "COMPLETED"
                 ((org-agenda-overriding-header "Completed Projects")
                  (org-agenda-files org-agenda-files)))
           (todo "CANCELLED"
                 ((org-agenda-overriding-header "Cancelled Projects")
                  (org-agenda-files org-agenda-files)))))))
 )
(add-hook 'org-mode-hook (lambda() (org-superstar-mode 1)))

(after! org-roam
  (map! :leader
        (:prefix-map ("r" . "roam")
                :desc "Roam daily note - today" "t" #'org-roam-dailies-capture-today
                :desc "Roam daily note - today" "T" #'org-roam-dailies-capture-tomorrow
                :desc "Roam daily note - today" "d" #'org-roam-dailies-capture-date
                )
        )
)

(require 'calibredb)
(setq calibredb-root-dir "~/Calibre Library")
(setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
(setq calibredb-library-alist `(("~/Calibre Library")))
(require 'nov)
;;(require 'ereader)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
;; (add-to-list 'auto-mode-alist '("\\.epub\\'" . ereader-mode))
