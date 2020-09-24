;(ql:quickload '(dexador closure-html cxml-stp lquery alexandria))

(require "dexador")
(require "lquery")
(require "alexandria")

(defvar *BROWSERS_COUNT_LIMIT* 50)
(defvar *BROWSERS_STATS_PAGE* "https://www.w3schools.com/browsers/default.asp")
(defvar *BROWSER_BASE_PAGE* "http://useragentstring.com/pages/useragentstring.php?name=")
(defvar *overides* '(("Edge/IE" . "Internet Explorer")("IE/Edge" . "Internet Explorer")))

(defparameter *request_w3* "")
(defparameter *doc* nil)
(defparameter *list-of-browsers-links* '())
(defparameter *list-of-browsers* '())
(defparameter *stat-of-browsers* '())
(defparameter *browsers_dict* '())
(defparameter *randomize_dict* '())


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
    (format nil "Error connect to https://www.w3schools.com")))
)  


(defun get_browser_versions(browser)
    "take user-agents from \"http://useragentstring.com/pages/useragentstring.php?name=\"
     and return list with this, but limit 50 (*BROWSERS_COUNT_LIMIT*)"
    
    (let ((*request_w3* (handler-case(dex:get  (concatenate 'string *BROWSER_BASE_PAGE* (substitute #\+ #\Space browser)))(t(c)(format nil "+ERROR+: ~a" c)))))
      (if (not(search "+ERROR+" *request_w3*)) 
    (let ((*doc* (lquery:$ (initialize *request_w3* ))))
    (split (coerce (lquery:$ *doc* "div ul li" (text)) 'list) *BROWSERS_COUNT_LIMIT*))
      (format nil "Error connect to http://useragentstring.com")))
) 


(defun load_()
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
	   ;; (dotimes (i up_number)
	   ;;   (setf res_list (append(list(cons count_ browser))res_list))
	   ;;   (setf count_ (+ count_ 1)))
	   ;;    (reverse res_list)))
       *list-of-browsers*))))
(if *browsers_dict* t nil) )   
)


(defun fake_user-agent()
(let((browser_list
 (let
    ((browser (let((rand (random(/(length *randomize_dict*)2))))
		(elt *randomize_dict*(+(position rand *randomize_dict*)1)))))
   (car(remove 'NIL (mapcar(lambda(x)(if(string= (car x) browser)(cdr x)))*browsers_dict*))))))
  (nth(random(length browser_list))browser_list))
  )


(if (load_) 
(fake_user-agent))
