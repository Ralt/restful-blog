# restful-blog

An example showing how to use [restful][0].

```
CL-USER> (drakma:http-request "http://localhost:4444/article"
                              :accept "application/json")
"[]"
200

CL-USER> (drakma:http-request "http://localhost:4444/article/foo"
                              :accept "application/json"
                              :method :put
                              :content "{\"slug\":\"foo\",\"title\":\"some article\"}")
"Created"
201

CL-USER> (drakma:http-request "http://localhost:4444/article/foo"
                              :accept "application/json"
                              :method :put
                              :content "{\"slug\":\"foo\",\"title\":\"some article\"}")
"No Content"
204

CL-USER> (drakma:http-request "http://localhost:4444/article/foo"
                              :accept "application/json")
"{\"slug\":\"foo\",\"title\":\"some article\",\"content\":\"\"}"
200

CL-USER> (drakma:http-request "http://localhost:4444/article/foo/comment"
                              :accept "application/json")
"[]"
200

CL-USER> (drakma:http-request "http://localhost:4444/article/foo/comment/bar"
                              :accept "application/json"
                              :method :put
                              :content "{\"id\":\"bar\",\"commenter\":\"foobar\",\"content\":\"test comment, pls ignore\"}")
127.0.0.1 - [2015-05-22 23:33:31] "PUT /article/foo/comment/bar HTTP/1.1" 201 0 "-" "Drakma/1.3.13 (SBCL 1.2.4-1.fc21; Linux; 3.19.7-200.fc21.x86_64; http://weitz.de/drakma/)"
"Created"
201

CL-USER> (drakma:http-request "http://localhost:4444/article/foo/comment/baz"
                              :accept "application/json"
                              :method :put
                              :content "{\"id\":\"baz\",\"commenter\":\"foobar\",\"content\":\"test comment, pls ignore\"}")
"Created"
201

CL-USER> (drakma:http-request "http://localhost:4444/article/foo/comment"
                              :accept "application/json")
"[{\"id\":\"baz\",\"commenter\":\"foobar\",\"content\":\"test comment, pls ignore\"},{\"id\":\"bar\",\"commenter\":\"foobar\",\"content\":\"test comment, pls ignore\"}]"
200
```


  [0]: https://github.com/Ralt/restful
