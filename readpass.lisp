(defpackage #:readpass
  (:use :cl :ltk)
  (:export :readpass))

(in-package :readpass)

(defun readpass ()
  "Opens TK window to enter password securely, then returns text."
  (let ((result nil))
    (ltk:with-ltk ()
      (let* ((main (make-instance 'ltk:frame :name "frame" :master nil))
             (message
               (make-instance 'ltk:message
                              :master main
                              :text "Enter message:"))
             (text
               (make-instance 'ltk:entry
                              :master main
                              :show "*"
                              :takefocus t)))
        (ltk:pack main)
        (ltk:pack message :side :left)
        (ltk:pack text :side :right)
        (ltk:bind text "<Return>"
                  (lambda (event)
                    (declare (ignore event))
                    (setf result
                          (ltk:text text))
                    (setf ltk:*exit-mainloop* t)))
        (ltk:force-focus text)))
    result))
