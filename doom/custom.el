(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(git-auto-commit-mode org-pomodoro org-journal-list org-roam org-journal)))
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

(setq org-todo-keywords
      '((sequence "TODO" "PROJ" "LATER" "WAIT" | "DONE" "CANCELED" "DELEGATED")))

