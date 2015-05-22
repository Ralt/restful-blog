;;;; package.lisp

(defpackage #:restful-blog
  (:use #:cl))

(in-package #:restful-blog)

(set-macro-character
 #\{
 (lambda (str char)
   (declare (ignore char))
   (let ((*readtable* (copy-readtable *readtable* nil))
         (keep-going t))
     (set-macro-character #\} (lambda (stream char)
                                (declare (ignore char) (ignore stream))
                                (setf keep-going nil)))
     (let ((pairs (loop for key = (read str nil nil t)
                     while keep-going
                     for value = (read str nil nil t)
                     collect (list key value)))
           (retn (gensym)))
       `(let ((,retn (make-hash-table :test #'equal)))
          ,@(mapcar
             (lambda (pair)
               `(setf (gethash ,(car pair) ,retn) ,(cadr pair)))
             pairs)
          ,retn)))))
