;;sbcl --noinform --load fake-user-agent.lsp --eval'(quit)'
 ;(ql:quickload '(dexador lquery alexandria bt-semaphore bordeaux-threads))

(require 'dexador)
(require 'lquery)
(require 'alexandria)
(require 'bt-semaphore)
(require 'bordeaux-threads)

;;;fake-user-agent
(defvar *BROWSERS_COUNT_LIMIT* 50)
(defvar *BROWSERS_STATS_PAGE* "https://www.w3schools.com/browsers/default.asp")
(defvar *BROWSER_BASE_PAGE* "http://useragentstring.com/pages/useragentstring.php?name=")
(defvar *overides* '(("Edge/IE" . "Internet Explorer")("IE/Edge" . "Internet Explorer")))

(defparameter *request_w3* "" "request from host")
(defparameter *doc* nil "lquery blob")
(defparameter *list-of-browsers* '())
(defparameter *browsers_dict* '())
(defparameter *randomize_dict* '())
(defparameter *console* *query-io* "multithreading output console")

;dexador:*default-read-timeout*
;dexador:*default-connect-timeout*
;dexador.util:*default-user-agent*

(defun split (list count)
  (values (subseq list 0 count) (nthcdr count list)))

(defun get_browsers()
"take last statistic from \"https://www.w3schools.com/browsers/default.asp\" and return it in list:
example -  ((\"Chrome\" . \"81.2%\") (\"Internet Explorer\" . \"4.6%\") (\"Firefox\" . \"7.3%\")
 (\"Safari\" . \"3.4%\") (\"Opera\" . \"2.0%\"))"
  (let((*request_w3* (handler-case(dex:get *BROWSERS_STATS_PAGE*)(t(c)(format nil "+ERROR+: ~a" c)))))
    (if (not(search "+ERROR+" *request_w3*))
	(let ((*doc* (lquery:$ (initialize *request_w3* ))))
	  (mapcar(lambda(x y)(cons x y))
		 (car(mapcar(lambda(x)(mapcar(lambda(y)(if(string= y (car x))(cdr x)y))
		        (cdr(cdr(remove "" (ppcre:split #\NewLine (remove #\Space(remove #\^M (lquery:$ *doc* "div table tr" (node 0)(text))))))))
			))
			    *overides*))	     
		 (cdr(cdr(remove "" (ppcre:split #\NewLine (remove #\Space(remove #\^M (lquery:$ *doc* "div table tr" (node 1)(text))))))))))
    *request_w3*))
)  


(defun get_browser_versions(browser)
    "take user-agents from \"http://useragentstring.com/pages/useragentstring.php?name=\"
     and return list with this, but limit 50 (*BROWSERS_COUNT_LIMIT*)"
    
    (let ((*request_w3* (handler-case(dex:get  (concatenate 'string *BROWSER_BASE_PAGE* (substitute #\+ #\Space browser)))(t(c)(format nil "+ERROR+: ~a" c)))))
      (if (not(search "+ERROR+" *request_w3*)) 
    (let ((*doc* (lquery:$ (initialize *request_w3* ))))
    (split (coerce (lquery:$ *doc* "div ul li" (text)) 'list) *BROWSERS_COUNT_LIMIT*))
      *request_w3*))
) 

(defun update-database-user-agents()
  (let ((*list-of-browsers* (get_browsers)))
    (setf *browsers_dict* (mapcar(lambda(x)(let((browser(string-downcase(remove #\_(remove #\Space(car x))))))
		       (cons browser(get_browser_versions (car x)))))
				 *list-of-browsers*))
    (setf *randomize_dict*
	  (alexandria:flatten
	  (let((count_ 0))
	    (mapcar(lambda(x)
	     (let((up_number (truncate(*(read-from-string(remove #\%(cdr x)))10)))
	      (browser(string-downcase(remove #\_(remove #\Space(car x))))))
	       (loop repeat up_number
		     do (setf count_ (+ count_ 1))
		     collect (cons count_ browser)
		     )))
       *list-of-browsers*))))
(if *browsers_dict* t nil) )   
)

(defun fake-user-agent()
(let((browser_list
 (let
    ((browser (let((rand (random(/(length *randomize_dict*)2))))
		(elt *randomize_dict*(+(position rand *randomize_dict*)1)))))
   (car(remove 'NIL (mapcar(lambda(x)(if(string= (car x) browser)(cdr x)))*browsers_dict*))))))
  (nth(random(length browser_list))browser_list))
)

;(bt:make-thread
;(lambda()
;(if (update-database-user-agents) 
;(format *console* "~a~%" (fake-user-agent)))))

;;;request
(require 'quri)
(if (not *browsers_dict*)(update-database-user-agents)) ; make fake user-agents list *browsers_dict*
;;;uri def
(defparameter *uri* "http://testphp.vulnweb.com")
(defparameter *render-uri* (quri:uri *uri*))
;;;headers def
(defparameter *additional-headers*
   '(("Accept" . "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    ("Accept-Language" . "en-US,en;q=0.5")
    ("Accept-Encoding" . "gzip, deflate")
    ("Connection" . "close")
    ))
(defparameter *additional-post-header* '(("Content-type" . "application/x-www-form-urlencoded")))
(defparameter *additional-close-header* '(("Connection" . "close")))
;;; request def
(defparameter *connect_timeout* 20 "connect timeout (default 20 seconds)")
(defparameter *read_timeout* 20 "read timeout (default 20 seconds)")
(defparameter *request_timeout* 60 "request timeout (default 60 seconds)")
(defparameter *response_size* 2000000 "response size limit (default 2000000 bytes)")
(defparameter *chunk-size* 256 "Files are downloaded in chunks of this many bytes.")
(defparameter *max_retries* 2 "max retries (default 2 times)")
(defparameter *max_redirect* 15 "max redirect (default 15 times)")
(defparameter *headers* t)
(defparameter *user-agent* "random")
(defparameter *default_user_agent* "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36")
(defparameter *random_user_agent* (if *browsers_dict* (fake-user-agent) nil)) 
(defparameter *headers*
  ;(if *uri*
  ;    (append(list(cons "Host" (quri:uri-host *render-uri*)))
  (if *headers*
    (append
     (list
     (cons "User-Agent" (cond ((string= *user-agent* "default")*default_user_agent*)((string= *user-agent* "random") (if *browsers_dict* (fake-user-agent) nil))(t *random_user_agent*)))); if user-agend default/random, if no user-agent, than random
     *additional-headers*)""));))
(defparameter *start_connect_time* 0)
(defparameter *received_body* 0 "received body content from server")
(defparameter *content_length* 0)
(defparameter *stream* nil)
(defparameter response-headers nil)
(defparameter body nil)
(defparameter status nil)
(defparameter response-headers nil)
(defparameter uri nil)
(defparameter stream_ nil)

;; (defun file-size (url)
;;   "Take a URL, return the size (in bytes)."
;;   (handler-case
;;       (parse-integer
;;         (gethash "content-length"
;;                (third (multiple-value-list
;;                        (dex:head url)))))
;;     (t () nil)))


;;https://github.com/eudoxia0/trivial-download/blob/master/src/trivial-download.lisp
(defparameter +size-symbol-map+
  (list (cons 1000000000000 "TB")
        (cons 1000000000 "GB")
        (cons 1000000 "MB")
        (cons 1000 "kB")
        (cons 1 "B")))

(define-condition http-error (error)
  ((code :initarg :code :accessor response-code))
  (:report (lambda (c s)
             (format s "HTTP error, response code ~S." (response-code c)))))


(defun http-request (url &rest args)
  (let* ((vals (multiple-value-list (apply #'dexador:get url args)))
         (code (second vals)))
    (unless (= 200 code)
      (format *console* "~a" 'http-error :code code))
    (values-list vals)))


(defun human-file-size (size)
  "Take a file size (in bytes), return it as a human-readable string."
  (let ((pair (loop for pair in +size-symbol-map+
                    if (or (>= size (car pair))
                           (= (car pair) 1))
                    return pair)))
    (format nil "~f ~A" (/ size (car pair)) (cdr pair))))

(defmacro with-download (url (file-size total-bytes-read array stream &key quiet)
                         &body body)
  "Execute body at every chunk that is downloaded."
  `(let* ((,file-size (file-size ,url))
          (,total-bytes-read 0)
          (,array (make-array *chunk-size* :element-type '(unsigned-byte 8)))
          (,stream (http-request ,url
                                 :want-stream t)))
     (unless quiet
       (format t "Downloading ~S (~A)~&" ,url (if ,file-size
                                                  (human-file-size ,file-size)
                                                  "Unknown size")))
     (finish-output nil)
     ;; We read the file in `*chunk-size*`-byte chunks by using `read-sequence`
     ;; to fill `array`. The return value of `read-sequence`, in this context,
     ;; is the number of bytes read. we know we've reached the end of file when
     ;; the number of bytes read is less than `*chunk-size*`
     (loop do
       (let ((bytes-read-this-chunk (read-sequence ,array ,stream)))
         (incf ,total-bytes-read bytes-read-this-chunk)
         ,@body
         (if (< bytes-read-this-chunk *chunk-size*)
             (return))))
     (close ,stream)))

(defparameter array_ nil)
(defparameter total-bytes-read 0)
(defparameter bytes-read-this-chunk 0)
(defparameter reads-body "")
(defparameter time-request 0)
(defparameter *cookie-jar* nil)
(defparameter download-size 0)
(defparameter time-request 0)

(defun decompress-body (content-encoding body)
  (unless content-encoding
    (return-from decompress-body body))

  (cond
    ((string= content-encoding "gzip")
     (if (streamp body)
	 (chipz:make-decompressing-stream :gzip body)
	 (chipz:decompress nil (chipz:make-dstate :gzip) body)))
    ((string= content-encoding "deflate")
     (if (streamp body)
	 (chipz:make-decompressing-stream :zlib body)
	 (chipz:decompress nil (chipz:make-dstate :zlib) body)))
        (t body)))


(defun test1 (uri &optional body_callback headers_callback cookie_callback)
(let ((*start_connect_time* (get-internal-real-time))
      (total-bytes-read 0)
      (download-size 0)
      (time-request 0)
      (reads-body "")
      (*cookie-jar* (cl-cookie:make-cookie-jar)))
  (multiple-value-bind (body status response-headers uri)
     (handler-case 
	 (handler-bind
	     ((dex:http-request-forbidden #'dex:ignore-and-continue)
	      (dex:http-request-not-found #'dex:ignore-and-continue)
	      (dex:http-request-bad-request #'dex:ignore-and-continue))
	   (dex:get uri :cookie-jar *cookie-jar*  :headers *headers* :use-connection-pool nil :connect-timeout *connect_timeout* :read-timeout *read_timeout* :want-stream t)
	)
       (dex:http-request-failed (e)
	 (format *error-output* "+Error+: The server returned ~D" (dex:response-status e)))
       (t(c)(format *console* "+Error+: ~a" c)))
    (if cookie_callback (funcall cookie_callback *cookie-jar*))
 (if body
   (progn 	
     (if response-headers
	(progn 
    (let((content-length (gethash "content-length"  response-headers)))
      (if content-length (setf *content_length* (parse-integer content-length)))
      (if ( < *response_size* *content_length*)
	  (progn(format *console* "+Error+: big length: ~a, limit: ~a" *content_length* *response_size*)(close body))))
    (if headers_callback (funcall  headers_callback response-headers))
    )
    )
(finish-output nil)
(if (search "CHAR"  (string (ignore-errors(stream-element-type body)))) ; check binary page or not
(let((array_ (make-string *chunk-size*)));(make-array *chunk-size* :element-type (stream-element-type body))
    (setf reads-body	  
      (loop for size-reads-chunk  = (read-sequence array_ body)
            while (plusp size-reads-chunk)
            summing  size-reads-chunk into size-reads-chunks
            do (setf reads-body (concatenate 'string  reads-body array_))
            when (> size-reads-chunks *response_size*)
	      do (progn(format *console* "+Error+: big length: ~a, limit: ~a" *content_length* *response_size*) (close body))
	    when (> (coerce (/(- (get-internal-real-time)  *start_connect_time*)internal-time-units-per-second)'single-float)  *request_timeout*)
	      do (progn(format *console* "+Error+: long delay: ~3,1f sec, limit: ~a sec" (/(- (get-internal-real-time)  *start_connect_time*)internal-time-units-per-second) *request_timeout*) (close body))
	    finally (return (values (subseq  reads-body  0 size-reads-chunks) (setf time-request  (/(- (get-internal-real-time)  *start_connect_time*)internal-time-units-per-second) download-size (human-file-size size-reads-chunks))))
	    )))
(progn(let(;(body (if(gethash "content-encoding" response-headers) (decompress-body (gethash "content-encoding" response-headers) body) body))
	   (array_ (make-array 36 :element-type '(unsigned-byte 8))))(read-sequence array_ body)(format *console* "+Error+: seems page is binary: ~a"  (loop for i from 0 to 31 for x across array_ collect (write-to-string x :base 16))))(close body));error about binary file and get 32 bits this file 
      )
    (if body_callback (funcall  body_callback reads-body))
    )
   ))
  (format t "~a on ~4,3f sec"  download-size time-request))
)

(test1 *uri*); return T or Error
(test1 *uri* #'print); show body
(test1 *uri* nil #'(lambda(x)(maphash #'(lambda (k v)(format t "~a = ~a~%" k v))x))); print all headers
(test1 *uri* nil #'(lambda(x)(format t "~a" (gethash "server" x)))); search value in server headers
(test1 *uri*
       #'(lambda(x)(format t "~a~%" (lquery:$(lquery:$ (initialize x))"div ul li a" (attr :href)))) ; body callback show all hrefs in DOM
       #'(lambda(x)(format t "~a~%" (gethash "server" x))) ; headers callback search value in server headers
       
)
(test1 *uri*
       #'(lambda(x)(format t "~a~%" (cl-ppcre:all-matches-as-strings "acunetix.com" x))) ; body search acunetix.com in body
       #'(lambda(x)(format t "~a~%" (gethash "server" x))) ; headers callback search value in server headers
)


(setf *uri1* "https://cdn.sstatic.net/Sites/security/Img/logo.svg?v=f9d04c44487b")
(test1 *uri* nil nil #'(lambda(x)(print (cl-cookie:cookie-jar-cookies x))))
(test1 "https://ati.su" nil  #'(lambda(x)(format t "headers:~%")(maphash #'(lambda (k v)(format t "~a = ~a~%" k v))x)) #'(lambda(x)(format t "~%cookies:~%~a~%~%" (cl-cookie:cookie-jar-cookies x))))
