;;;; restful-blog.lisp

(in-package #:restful-blog)

;;; "restful-blog" goes here. Hacks and glory await!

(defclass article (restful:resource)
  ((slug :is-identifier t :reader slug)
   (title :required t)
   (content :default ""))
  (:metaclass restful:resource-metaclass))

(defclass comment (restful:resource)
  ((id :is-identifier t)
   (commenter :required t)
   (content :required t))
  (:metaclass restful:resource-metaclass))

(defclass user (restful:resource)
  ((action :is-identifier t :reader action))
  (:metaclass restful:resource-metaclass))

(defmethod restful:has-permission ((user user) method)
  ;; Only POST methods available, i.e. custom actions
  (eq method :post))

(defmethod restful:resource-action ((user user))
  (cond ((string= (slug user) "login") (handle-login))
        ((string= (slug user) "logout") (handle-logout))
        (t (restful::http-error hunchentoot:+http-not-found+))))

(defun handle-login ()
  t)

(defun handle-logout ()
  t)

(defun main ()
  (hunchentoot:start
   (make-instance 'restful:acceptor
                  :port 4444
                  :resource-definition {
                    "article" {
                      :class 'article
                      :collection 'restful:collection
                      :storage (make-instance 'restful:memory-storage)
                      :children {
                        "comment" {
                          :class 'comment
                          :collection 'restful:collection
                          :storage (make-instance 'restful:memory-storage)
                        }
                      }
                    }
                    "user" {
                      :class 'user
                      :collection 'restful:collection
                      :storage t
                    }
                  })))
