;;;;    		      	
; tables.scm - Fall 2018    		      	
;    		      	
; this project deals with some simple relational databases, using
; abstract data types    		      	
;;;;    		      	
    		      	
;;;;;;;;;;;;;;;;;;;;;    		      	
;;;; some basics ;;;;    		      	
;;;;;;;;;;;;;;;;;;;;;    		      	
    		      	
; filter implementation R5RS does not include it!
(define (filter f items)    		      	
  (cond    		      	
    ((null? items) '())    		      	
    ((f (car items))    		      	
     (cons (car items) (filter f (cdr items))))
    (else (filter f (cdr items)))))
    		      	
; error    		      	
(define (error reason . args)    		      	
      (display "Error: ")    		      	
      (display reason)    		      	
      (for-each (lambda (arg)    		      	
                  (display " ")
		  (write arg))    		      	
		args)    		      	
      (newline)    		      	
      (scheme-report-environment 5))
; compose    		      	
(define (compose f g)    		      	
  (lambda (x)    		      	
    (f (g x))))    		      	
    		      	
; tagged data    		      	
;    		      	
(define (tag-check object tag)    		      	
  (and (pair? object)    		      	
       (eq? tag (car object))))
    		      	
(define (tag object)    		      	
  (if (pair? object)    		      	
      (car object)    		      	
      (error "object not tagged data")))
    		      	
(define (contents object)    		      	
  (if (pair? object)    		      	
      (cdr object)    		      	
      (error "object not tagged data")))
    		      	
;;;;;;;;;;;;;;;;;;;;    		      	
;;;; type-table ;;;;    		      	
;;;;;;;;;;;;;;;;;;;;    		      	
    		      	
; definition - association list of
;  (name checker comparator)    		      	
;    		      	
; checker:  A->boolean    		      	
;  returns #t if type of A matches type
; comparator:  T,T->boolean    		      	
;  returns #t if first arg is "less than" second arg
;    		      	
    		      	
(define (symbol<? s1 s2)    		      	
  (string<? (symbol->string s1) (symbol->string s2)))
    		      	
(define *type-table*    		      	
  (list    		      	
        (list 'number number? <)
        (list 'symbol symbol? symbol<?)))
    		      	
(define (type-checker type)    		      	
  ; looks up the checker for the given type
  ; in the type-table    		      	
  (let ((r (assq type *type-table*)))
    (if r    		      	
	(cadr r)    		      	
	(error "unknown type" type))))
    		      	
(define (type-comparator type)    		      	
  ; looks up the comparator for the given type
  ; in the type-table    		      	
  (let ((r (assq type *type-table*)))
    (if r    		      	
	(caddr r)    		      	
	(error "unknown type" type))))
    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;    		      	
;;;; column abstraction ;;;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;    		      	
    		      	
(define (make-column name type)
  ; constructor:  name,type -> column
  (list name type))    		      	
    		      	
(define (column-name col)    		      	
  ; selector: column->name    		      	
  (car col))    		      	
    		      	
(define (column-type col)    		      	
  ; selector: column->type    		      	
  (cadr col))    		      	
    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;    		      	
;;;; row abstraction ;;;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;    		      	
    		      	
; tag definition    		      	
(define *row-tag* 'row)    		      	
    		      	
(define (make-row cols row-data)
  ; constructor: list<column>,list -> row
  (cons *row-tag*    		      	
	(map (lambda (col datum) ;note: uses built-in map
	       (cons col datum)) ; which can take two lists
	     cols    		      	
	     row-data)))    		      	
    		      	
(define (row? x)    		      	
  ; predicate:  A->boolean    		      	
  (tag-check x *row-tag*)) ; correction - was tag-check?
    		      	
(define (row-columns row)    		      	
  ; selector:  row -> list<columns>
  (map car (contents row)))    		      	
    		      	
(define (row-data row)    		      	
  ; selector: row -> list    		      	
  (map cdr (contents row)))    		      	
    		      	
    		      	
(define (rlookup colname row-contents)
  ; internal procedure for looking up the item in the
  ; row based on the column name
  (let ((data (filter (lambda (x) (eq? colname (column-name (car x))))
                      row-contents)))
    (if (null? data)    		      	
        #f    		      	
        (car data))))    		      	
    		      	
    		      	
(define (get colname row)    		      	
  ; selector: column-name,row -> value
  ; looks up a value in row based on column-name
  (let ((result (rlookup colname (contents row))))
    (if result    		      	
	(cdr result)    		      	
	(error "Bad column name in get"))))
    		      	
(define (row-col-replace row colname newvalue)
  ; update:  row,column-name,value -> row
  ; returns a new row with the value in column replaced with newvalue
  ; doesn't verify that the new data matches the type
  (define (helper row-data)    		      	
    (cond ((null? row-data)    		      	
	   (error "unknown col in row-col-replace"))
	  ((eq? colname (column-name (caar row-data)))
	   (cons (cons (caar row-data) newvalue) (cdr row-data)))
	  (else    		      	
	   (cons (car row-data)
		 (helper (cdr row-data))))))
  (cons *row-tag* (helper (contents row))))
    		      	
(define (row-display row)    		      	
  ; prints out values of row    		      	
  (for-each (lambda (val)    		      	
	      (display val) (display "\t"))
	    (row-data row)))    		      	
    		      	
(define (row-type-check row)    		      	
  ; row->boolean    		      	
  ; verifies that the data in the row matches the types
  ; specified for the columns    		      	
  (define (check-helper cols data)
    (if (null? cols)    		      	
	#t    		      	
	(let ((col (car cols))    		      	
	      (datum (car data)))
	  (if ((type-checker (column-type col))  datum)
	      (check-helper (cdr cols) (cdr data))
	      #f))))    		      	
  (check-helper (row-columns row) (row-data row)))
    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;    		      	
;;;; table abstraction ;;;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;    		      	
    		      	
; tag definition    		      	
(define *table-tag* 'table)    		      	
    		      	
(define (table? x)    		      	
  ; predicate    		      	
  (tag-check x *table-tag*))    		      	
    		      	
(define (make-empty-table cols)
  ; list<column> -> table    		      	
  (make-table cols '()))    		      	
    		      	
(define (make-table cols data)    		      	
  ; internal proc - list<column>,list<row> -> table
  (list *table-tag* cols data))
    		      	
(define (get-table-columns table)
  ; selector: table -> list<column>
  (cadr table))    		      	
    		      	
(define (get-table-data table)    		      	
  ; selector: table -> list<row>
  (caddr table))    		      	
    		      	
(define (change-table-data! table newdata)
  ; selector: table,list<row> -> table
  ; actually modifies table, ignore details of how
  (set-car! (cddr table) newdata)
  table)    		      	
    		      	
(define (empty-table? table)    		      	
  ; returns true if the table is empty
  (null? (get-table-data table)))
    		      	
(define (table-num-rows table)    		      	
  ; returns number of rows in table
  (length (get-table-data table)))
    		      	
(define (table-nth-row n table)
  ; extracts nth row from the table
  (list-ref (get-table-data table) n))
    		      	
(define (table-map proc table)    		      	
  ; maps proc over the rows of the table
  (map proc (get-table-data table)))
    		      	
(define (fold-right proc init lst)
  (if (null? lst)    		      	
      init    		      	
      (proc (car lst) (fold-right proc init (cdr lst)))))
    		      	
(define (table-fold-right proc init table)
  ; fold-right of proc,init over the table
  (fold-right proc init (get-table-data table)))
    		      	
(define (table-display table)    		      	
  ; displays a table    		      	
  ;  displays column names, then row by row
  (for-each (lambda (col)    		      	
	      (display (column-name col)) (display "\t"))
	    (get-table-columns table))
  (newline)    		      	
  (for-each (lambda (row)    		      	
	      (row-display row) (newline))
	    (get-table-data table)))
    		      	
(define (make-row-comparator colname table)
  ; given a column name and a table, finds an appropriate
  ; comparator for the type of the column
  (let* ((cols (get-table-columns table))
	 (col (assq colname cols))
	 (comp (type-comparator (column-type col))))
    (lambda (r1 r2)    		      	
      (comp (get colname r1)    		      	
	    (get colname r2)))))
    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; table manipulation procs ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
(define (table-insert! row-data table)
  ; list,table -> table    		      	
  ; modifies & returns the table to include the new row
  ; assuming that the row-data passes the type-check
  (let ((new-row (make-row (get-table-columns table)
                           row-data)))
    (if (row-type-check new-row)
        (change-table-data!    		      	
         table    		      	
         (cons new-row (get-table-data table)))
        (error "type check failed in insert" row-data))))
;;;    		      	
;some useful procedures    		      	
;;;    		      	
    		      	
(define (find-best pred best rest)
  (if (null? rest)    		      	
      best    		      	
      (if (pred best (car rest))
          (find-best pred best (cdr rest))
          (find-best pred (car rest) (cdr rest)))))
    		      	
(define (remove elt lst)    		      	
  (if (null? lst)    		      	
      '()    		      	
      (if (eq? elt (car lst))    		      	
          (remove elt (cdr lst))
          (cons (car lst) (remove elt (cdr lst))))))
    		      	
(define (sort predicate lst)    		      	
  (if (null? lst)    		      	
      '()    		      	
      (let ((next (find-best predicate (car lst) (cdr lst))))
        (let ((rest (remove next lst)))
          (cons next (sort predicate rest))))))
    		      	
