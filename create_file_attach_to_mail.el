;; === elisp ===
;; == Create file from paste, compose mail with paste and file attached, send mail ==
;; - set variables -
(setq subject " test mail subject  "
        date (format-time-string "%Y-%m-%d")
        name  " test name "
        val " v 1421153 "
        tags " -- tag1 tag2 "
        ext  ".txt"
        path "/tmp/"
        ;path  "~/Dropbox/yo/"
        fpath (concat path date name val tags ext)
        paste "\n\n

text to paste

\n\n")
;; - create empty file
(write-region paste nil fpath)
;; - start smtp server, compose mail, verify buffer, send whith C-c C-c
(setq smtpmail-stream-type 'ssl)
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 465)
(progn
  (mail)
  (compose-mail "yourMail@domain.com" subject nil nil nil nil nil nil)
  (mail-text) (insert paste)
  (mml-attach-file fpath "text/x-patch" nil "attachment")
  (mail-send)
  )
