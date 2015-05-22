;;;; restful-blog.lisp

(in-package #:restful-blog)

;;; "restful-blog" goes here. Hacks and glory await!

(defclass article (restful:resource)
  ((slug :is-identifier t)
   (title :required t)
   (content :default ""))
  (:metaclass restful:resource-metaclass))

(defclass comment (restful:resource)
  ((id :is-identifier t)
   (commenter :required t)
   (content :required t))
  (:metaclass restful:resource-metaclass))

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
                }))
