(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/home/em/org/calendar.org" "/home/em/org/collection.org" "/home/em/org/emacs.org" "/home/em/org/example.org" "/home/em/org/gtd.org" "/home/em/org/journal.org" "/home/em/org/linked.org" "/home/em/org/mentorship.org" "/home/em/org/orgmode.org" "/home/em/org/people.org" "/home/em/org/pomodoro.org" "/home/em/org/projects.org" "/home/em/org/reading.org" "/home/em/org/vc-ref.org"))
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
   '(ereader hnreader nov calibredb org-roam-server projectile-git-autofetch org-pomodoro org-journal-list org-roam org-journal)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key (kbd "C-c C-'") 'org-edit-src-code)
(global-set-key (kbd "C-!") (lambda() (interactive)(find-file "~/org/collection.org")))
(map! :leader
      :prefix "w"
        :desc "Find window" "f" #'ace-window)

(setq org-file-apps
    (quote
        ((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . "/usr/bin/microsoft-edge-dev %s")
        ("\\.pdf\\'" . default))))

;; org-journal + org-journal-list
(setq org-journal-dir "~/org/journal/")
(setq org-journal-date-format "%A, %d %B %Y")
(require 'org-journal)

(setq org-journal-list-default-directory "~/notes/")
(require 'org-journal-list)
(require 'org-pomodoro)
(after! org
  (require 'git-auto-commit-mode)
   (setq org-todo-keywords '((sequence "TODO( )" "PROJ(p)" "LATER(l)" "WAIT(w)" "[ ](T)" "[P](P)" "[?](W)" "[X](D)" "|" "DONE(X)" "CANCELED(-)" "DELEGATED(>)")))
   (setq-default gac-automatically-push-p t)
   (add-to-list 'org-capture-templates
      '("r" "Book" entry (file "~/org/reading.org")
         "* %^{TITLE}\n:PROPERTIES:\n:ADDED: %<[%Y-%02m-%02d]>\n:END:%^{AUTHOR}p\n%?" :empty-lines 1))
  )

(require 'calibredb)
(setq calibredb-root-dir "~/Calibre Library")
(setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
(setq calibredb-library-alist `(("~/Calibre Library")))
(require 'nov)
;;(require 'ereader)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
;; (add-to-list 'auto-mode-alist '("\\.epub\\'" . ereader-mode))
