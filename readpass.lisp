(defpackage #:readpass
  (:use :cl :ltk)
  (:export :readpass))

(in-package :readpass)

(defun readpass ()
  "Opens TK window to enter password securely, then returns text."
  (let ((result nil))
    (with-ltk ()
      (let* ((main (make-instance 'frame :name "frame" :master nil))
             (message
               (make-instance 'message
                              :master main
                              :text "Enter message:"))
             (text
               (make-instance 'entry
                              :master main
                              :show "*"
                              :takefocus t)))
        (pack main)
        (pack message :side :left)
        (pack text :side :right)
        (bind text "<Return>"
              (lambda (event)
                (declare (ignore event))
                (setf result
                      (text text))
                (setf *exit-mainloop* t)))
        (force-focus text)))
    result))
