;;;; restful-blog.asd

(asdf:defsystem #:restful-blog
  :description "A blog using restful"
  :author "Florian Margaine <florian@margaine.com>"
  :license "MIT License"
  :serial t
  :depends-on (:restful)
  :components ((:file "package")
               (:file "restful-blog")))
