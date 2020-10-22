;;; masgun17@ku.edu.tr    Wed Nov 14 17:19:49 2018
;;;    		      	
;;; Comp200 Project 3    		      	
;;;    		      	
;;; Due December 2, 2018    		      	
;;;    		      	
;;;    		      	
;;; Before you start:    		      	
;;;    		      	
;;; * Please read the detailed instructions for this project from the
;;; file project3.pdf available in the course website.
;;;    		      	
;;; !!! In question 7, 8 and 9, you will modify the type-table. Keep in mind that
;;; * when you define new types, you should keep the previous types as well.
;;; * In other words, you should not delete previously defined types from type-table.
;;; * TLDR: Please, append the new types under already existing types in the table.
;;;    		      	
;;;    		      	
;;; While you are working:    		      	
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code.
;;; * Remember our collaboration policy: you can discuss with your friends but:
;;;    		      	
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;    		      	
;;; !!! Do that before submitting the project:
;;;  When you are done with the project3.scm, please click on the "file" button at
;;;  the upper left side, go to the "Save Other" section and click on the
;;; "Save Definitions As Text..." item. It is important for you to do that before the submission.
;;;  Don't worry, this won't change anything in your code; but is required for grading.
;;;    		      	
;;;    		      	
;;; When you are done:    		      	
;;;    		      	
;;; * Perform a final save and submit your work following the instructions.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email comp200@ku.edu.tr if you have any questions.
;;; * Make sure your file loads without errors:
;;;    		      	
;;; *** IF LOADING GIVES ERRORS YOUR PROJECT WILL NOT BE GRADED ***
;;;    		      	
;;; Before the definition of each procedure, please write a description
;;; about what the procedure does and what its input and output should
;;; be, making sure the lines are commented out with semi-colons.
;;;    		      	
;;; Code for this project: "databases.scm". You should read this file
;;; since you will use the procedures defined in it.
;;;    		      	
;;;   Completing assignment by using Racket/DrRacket
;;;   By default DrRacket does not allow you to redefine primitives and
;;;   also load external files via load procedure. To fix these problems,
;;;   in the "Choose Language" panel, select R5RS language in "Other
;;;   Languages" section, click on "Show Details" and uncheck "Disallow
;;;   redefinition of initial bindings".
;;;    		      	
;;;    		      	
;;; *** Tips for project:    		      	
;;; Please try to use data abstraction as much as possible i.e.,
;;; don't use primitive operations if there is already a defined method for that job.
;;; Moreover, as you build more complicated structures or methods, do not spend too much
;;; time thinking about the internal representations unless you have to.
;;;    		      	
;;; The example table picture(with colors) supplied in the project description is extremely useful.
;;; Try to fully understand it at before starting writing code, and refer it when you are stuck(i.e. frequently)
    		      	
;;; The following lines are necessary, please do not delete:
    		      	
(define your-answer-here -1)    		      	
(load "databases.scm")    		      	
    		      	
;;; Let's start 0_0    		      	
;;; problem 1 ;;;    		      	
    		      	
;; your code should have the following general form

; It creates an example table with given entries.
(define example-table    		      	
  (let ((a (make-empty-table (list (make-column 'name 'symbol) (make-column 'major 'number)))))
    (table-insert! (list 'ben '6) a)
    (table-insert! (list 'jen '3) a)
    (table-insert! (list 'amy '12) a)
    (table-insert! (list 'kim '13) a)
    (table-insert! (list 'alex '6) a)))
;(get-table-data example-table)
(table-display example-table)
    		      	
;; test cases    		      	
;; (table-display example-table)
    		      	
;;; problem 2 ;;;

; This method insert lists to the table recursively.
(define (table-insert-all! lst table)
  (if (null? lst)
      table
      (and (table-insert! (car lst) table) (table-insert-all! (cdr lst) table)))
)    		      	
;; test cases    		      	
    		      	
; (define books (make-empty-table
; 	       (list (make-column 'title 'symbol)
; 		     (make-column 'author 'symbol)
; 		     (make-column 'rating 'number))))
;    		      	
;    		      	
; (table-insert-all! '((sicp abelson-sussman 8)
; 		     (return-of-the-king jrr-tolkien 9)
; 		     (treatment-of-subordinates darth-vader 4)
; 		     (project-grading tom 2)
; 		     (all-things-stata frank-gehry 5)
; 		     (biting-the-hand-that-feeds-me my-cat 1))
; 		   books)    		      	
; (table-display books)

    		      	
;;; problem 3 ;;;    		      	
;; Hint: Writing (filter predicate lst) might be helpful

;(table-display (list *table-tag* (get-table-columns books) (filter (lambda (row) (> (get 'rating row) 4)) (get-table-data books))))
;(get-table-data (list *table-tag* (get-table-columns books) (filter (lambda (row) (> (get 'rating row) 4)) (get-table-data books))))

; filter selects the row with given conditions from the datas of the table.
; Then I created a new table with this rows and the column names.
(define (table-select selector table)
  (let ((cols (get-table-columns table)))
    (make-table cols (filter selector (get-table-data table)))))
    		      	
;; test cases    		      	
;    		      	
; (display "Testing Problem 3\n")
; (table-display    		      	
;  (table-select    		      	
;   (lambda (row)    		      	
;     (> (get 'rating row) 4))
;   books))    		      	

;(get-table-data (table-select    		      	
 ;  (lambda (row)    		      	
  ;   (> (get 'rating row) 4))
   ;books))

;;; problem 4 ;;;    		      	
    		      	
;; Hint: Be careful about the comparator operator of the corresponding
;; row.  Writing a (get-column-type row column-name) might be helpful.

; make-row-comparator finds an appropriate comparator for type of the column of the given table,
; sort, simply sorts these rows from the datas of the table by the comparator founded by
; make-row-comparator. Then I created a new table with same method as before.
(define (table-order-by column table)
  (let ((cols (get-table-columns table)))
    (make-table cols (sort (make-row-comparator column table) (get-table-data table)))
    ))    		      	

;(define a (make-row-comparator 'author books))
;(sort a (get-table-data books))

;; test cases    		      	
;(display "Testing Problem 4\n")
;(table-display    		      	
; (table-order-by 'rating books)
; )    		      	
;    		      	
;(table-display    		      	
; (table-order-by 'title books)
; )    		      	
    		      	
;;; problem 5 ;;;    		      	
    		      	
; I created a helper method for this one. This helper takes two datas, a predicate and a list of
; items. If items is empty it returns an empty list. If predicate holds for the car of the items
; it recalls itself for the cdr of the items. If predicate doesnt hold it glues the car of the items
; and the remaining list's results under delete-method. So that the row, which we want to delete
; will be overwritten. Then on the main part, I used change-table-data! to manipulate the table.
(define (table-delete! pred table)
  (define (delete-filter pred items)
  (cond ((null? items) '())
        ((pred (car items))
         (delete-filter pred (cdr items)))
        (else (cons (car items) (delete-filter pred (cdr items))))))
  (change-table-data! table (delete-filter pred (get-table-data table))))

 
;; test cases    		      	
; (display "Testing Problem 5\n")
; (table-delete!    		      	
;  (lambda (row)    		      	
;   (eq? (get 'author row) 'my-cat))
; books)    		      	
;
; (table-display books)    		      	
    		      	
;; problem 6 ;;;    		      	

; I defined a helper inside the main method. It maps the new row, created by row-col-replace, over the
; datas of the main table, of course it does it only when the predicate returns true. Then again, I used
; change-table-data! to manipulate the data.
(define (table-update! pred column proc table)
  (define helper
    (map (lambda (x) (if (pred x)
                         (row-col-replace x column (proc x))
                         x))
         (get-table-data table)))
  (if (row-type-check (car helper))
      (change-table-data! table helper)
      "Error"))
  

;test cases
    		      	
; (display "Testing Problem 6\n")

;(table-update! (lambda (row) (eq? (get 'name row) 'amy)) 'major (lambda (row) '9) example-table)
;(table-display example-table)

; (table-update! (lambda (row) (or (eq? (get 'name row) 'amy) (eq? (get 'name row) 'alex)))
;               'major    		      	
;               (lambda (row) '9)
;               example-table)
; 
; (table-display example-table)
;
;(table-update! (lambda (row) (or (eq? (get 'name row) 'amy) (eq? (get 'name row) 'alex)))
;               'major    		      	
;               (lambda (row) 'a)
;               example-table)
;(table-display example-table)
    		      	
;;; problem 7 ;;;    		      	
    		      	
; I simply created a new string type and then created a new table with this type.
(define *type-table*    		      	
  (list (list 'number number? <)
        (list 'symbol symbol? symbol<?)
        (list 'string string? string<?)))    		      	
    		      	
(define example-table2    		      	
  (make-empty-table (list (make-column 'name 'string) (make-column 'major 'number)))
   )

    		      	
;; test cases    		      	
; (display "Testing Problem 7\n")
; (table-insert! '("jen" 3) example-table2)
; (table-insert! '("ben" 6) example-table2)
; (table-insert! '("alex" 6) example-table2)
; (table-insert! '("amy" 12) example-table2)
; (table-insert! '("kim" 13) example-table2)
;    		      	
;    		      	
; (table-display example-table2)
; (display "\nordered example-table2\n")
; (table-display    		      	
;  (table-order-by 'name example-table2)
; )    		      	
    		      	
;;; problem 8 ;;;    		      	
    		      	
;; Hint: Writing these two procedures might be helpful (contains? lst
;; x) returns true if x in the lst and (get-pos lst x) returns the
;; position of x if it is in the list.
;; Ex: (get-pos '(1 2 3 4) 2) => 2
;;     (get-pos '(1 2 3 4) 5) => 0


; First I wrote the contains? and get-pos procedures. contains? returns true if given x is a member
; of the list( member x lst method prints a list including x, so I check whether it is in a list or
; not). get-pos recursively looks the first item in the list and count the number.
(define (contains? lst x)
  (if (list? (member x lst)) #t #f))

(define (get-pos lst x)
    (if (contains? lst x)
        (if (eq? (car lst) x)
            1
            (let ((result (get-pos (cdr lst) x)))
                (if (eq? result 0)
                    0
                    (+ 1 result))))
        0))

; test cases
;(get-pos '(1 2 3 4) 2)
;(get-pos '(1 2 3 4) 5)


; If lst contains the given n, it returns #t, otherwise #f.
(define (make-enum-checker lst)
  (lambda (n)
    (if (contains? lst n)
        #t
        #f
  )))    		      	

; It gets the positions of entries in the original list and then comparas them.
(define (make-enum-comparator lst)
  (lambda (n1 n2)
    (let ((a (get-pos lst n1)) (b (get-pos lst n2)))
      (if (< a b)
          #t
          #f
))))    		      	

(define *days* '(sunday monday tuesday Wednesday thursday friday saturday))
(define day-checker (make-enum-checker *days*))
(define day-comparator (make-enum-comparator *days*))
    		      	
;; test cases    		      	
; (display "Testing Problem 8\n")
; (day-checker 'monday)   ;=> #t
; (day-checker 7)         ;=> #f
; (day-comparator 'monday 'tuesday)   ;=> #t (monday is "less than" tuesday)
; (day-comparator 'friday 'sunday)    ;=> #f (sunday is before friday)
    		      	

; I simply added the day method to the type table. And then created a new table using day type.
(define *type-table*    		      	
  (list (list 'number number? <)
        (list 'symbol symbol? symbol<?)
        (list 'string string? string<?)
        (list 'day day-checker day-comparator))
)    		      	
    		      	
; (define example-table3    		      	
;   (make-empty-table    		      	
;    (list (make-column 'name 'string)
;          (make-column 'date 'day)
;          (make-column 'major 'number)))
;    )    		      	
;    		      	
; (table-insert! '("jen" monday 3) example-table3)
; (table-insert! '("ben" sunday 6) example-table3)
; (table-insert! '("alex" friday 6) example-table3)
; (table-insert! '("amy" tuesday 1) example-table3)
; (table-insert! '("kim" saturday 2) example-table3)
;    		      	
; (table-display example-table3)
; (display "\nordered example-table3\n")
; (table-display    		      	
;  (table-order-by 'date example-table3)
; )    		      	
    		      	
;;; Problem 9    		      	
;; Hint: Similar with Problem 8
(define *gender* '(male female))

; I used the checker and comparator methods that I created above. Again they simply, checks and comparates
; given entries, first for gender, second for race.
(define gender-checker    		      	
  (make-enum-checker *gender*
))    		      	

(define gender-comparator    		      	
  (make-enum-comparator *gender*)
)    		      	

(define *race* '(white black red))
    		      	
(define race-checker    		      	
  (make-enum-checker *race*)
)    		      	

(define race-comparator    		      	
  (make-enum-comparator *race*)
)    		      	
    		      	
; I added the gender and race types to type table.
(define *type-table*    		      	
  (list (list 'number number? <)
        (list 'symbol symbol? symbol<?)
        (list 'string string? string<?)
        (list 'day day-checker day-comparator)
        (list 'gender gender-checker gender-comparator)
        (list 'race race-checker race-comparator))
)    		      	


; test case
;(define example-table4   		      	
;   (make-empty-table    		      	
;    (list (make-column 'name 'string)
;          (make-column 'date 'day)
;          (make-column 'major 'number)
;          (make-column 'sex 'gender)
;          (make-column 'color 'race)))
;    ) 
;
;(table-insert! '("jen" monday 3 female white) example-table4)
;(table-insert! '("ben" sunday 6 male white) example-table4)
;(table-insert! '("alex" friday 6 male black) example-table4)
;(table-insert! '("amy" tuesday 1 female red) example-table4)
;(table-insert! '("kim" saturday 2 female black) example-table4)
;
;(table-display example-table4)
;
;(display "\nordered example-table4\n")
; (table-display    		      	
;  (table-order-by 'date example-table4)
; )
;
;(display "\nordered example-table4\n")
;(table-display    		      	
;  (table-order-by 'sex example-table4)
; )
;(display "\nordered example-table4\n")
;(table-display    		      	
;  (table-order-by 'color example-table4)
; )


;;; Problem 10    		      	
    		      	
; I created a new person-table using the types I created above.
(define person-table    		      	
  (make-empty-table
   (list (make-column 'name 'string)
         (make-column 'race 'race)
         (make-column 'gender 'gender)
         (make-column 'birthyear 'number)
)))



;;; tests    		      	
; (display "Testing Problem 10\n")
; (table-insert! '("jen" white female 1983) person-table)
; (table-insert! '("axe" black male 1982) person-table)
; (table-display person-table)
;;; additional tests
;(display "Additional for Problem 10\n")
;(table-insert! '("mike" black male 1987) person-table)
;(table-insert! '("adam" white male 1973) person-table)
;(table-insert! '("mary" red female 1985) person-table)
;(table-insert! '("james" white male 1991) person-table)
;(table-display person-table)
    		     
;;; Problem 11    		      	

; I created a method to add a person to the list automatically. Then when we call its name again, we
; can reach all of its datas.
(define (make-person name race gender birthyear)
  (table-insert! (list name race gender birthyear) person-table)
  name)    		      	
    		      	
;; test cases    		      	
    		      	
; (display "Testing Problem 11\n")
;    		      	
; (define p1 (make-person "Alex" 'white 'male 1983))
; (define p2 (make-person "Clark" 'black 'male 1982))
; (table-display person-table)
;;; additional tests
;(display "Additional for Problem 11\n")
;(define p3 (make-person "Noah" 'white 'male 1981))
;(define p4 (make-person "Julia" 'white 'female 1969))
; (table-display person-table)
;
;;; test for deletion
;(display "Deletion tests\n")
;(table-delete! (lambda (x) #t) person-table)
;(display "\nDeleted Person Table\n")
;(table-display person-table)
    		      	
;;; Note that you might delete the test people you created by typing
;; (table-delete! (lambda (x) #t) person-table)
;;; And you can verify the removal operation by typing
;; (display "\nDeleted Person Table\n")
;; (table-display person-table)
;;;    		      	
;;; Note that, you might need to create test people again in later questions
    		      	
    		      	
;;; Problem 12
    		      	
(define (person-name person) person)

; It filters the "person"s row from the datas of table. If it is not empty it returns it, otherwise
; it gives an error  message.
(define (lookup-person-row person)
  (let ((a (filter (lambda (row) (eq? (get 'name row) person)) (get-table-data person-table))))
    (if (eq? a '())
        "Error: Bogus name"
        (car a)
  )))

(define (person-race person)    		      	
  (get 'race (lookup-person-row person)))
    		      	
(define (person-gender person)    		      	
  (get 'gender (lookup-person-row person)))
    		      	
(define (person-birthyear person)
  (get 'birthyear (lookup-person-row person)))
    		      	
(define (person-age person)    		      	
; returns an approximation to the person's age in years
  (let ((*current-year* 2018))    		      	
    (- *current-year* (person-birthyear person))))
    		      	
;; Previous test cases
;(display "\nPrevious test cases implemented again\n")
;(table-insert! '("jen" white female 1983) person-table)
; (table-insert! '("axe" black male 1982) person-table)
;(define p1 (make-person "Alex" 'white 'male 1983))
; (define p2 (make-person "Clark" 'black 'male 1982))
; (table-display person-table)
;
;;;; Note that, you can create test people to check the selectors.
; (display "Testing Problem 12\n")
; (lookup-person-row p1)    		      	
; (person-race p1)    		      	
; (person-gender p1)    		      	
; (person-birthyear p1)    		      	
; (person-age p1)    		      	
; (lookup-person-row "UchihaMadara")
    		      	
;;; Problem 13    		      	

; Similar with table-update!, it looks for the row of the person, then replaces it with the new row
; including the newvalue, while not touching the other rows. At last, I used change-table-data! to
; manipulate the table.
(define (update-person-row! person colname newvalue)
  (define helper
    (map (lambda (x) (if (eq? (lookup-person-row person) x)
                         (row-col-replace (lookup-person-row person) colname ((lambda (row) newvalue) x))
                         x))
         (get-table-data person-table)))
(if (row-type-check (car helper))
    (change-table-data! person-table helper)
    "Error"))
  
(define (set-person-name! person newname)
  (update-person-row! person 'name newname))
    		      	
(define (set-person-race! person newrace)
  (update-person-row! person 'race newrace))
    		      	
(define (set-person-gender! person newgender)
  (update-person-row! person 'gender newgender))
    		      	
(define (set-person-birthyear! person newbirthyear)
  (update-person-row! person 'birthyear newbirthyear))
    		      	
;; QUESTION What happens? Why? Comments?
;your-answer-here
; In problem 12 person-name procedure is defined in a way that it always return the entered value,
; person. It is not searching the table, not deciding it is whether there or not, just returns
; the entered value. When we changed the name of the alyssa, we only changed the name value
; in the table, not in the alyssa definition. So when we call person-name procedure on alyssa,
; it search for alyssa definition and then returns the original name. On the next test case,
; we tried to reach the race of the alyssa using person-race. This procedure simply finds
; the gender of given person in the table. However, again we called the alyssa definition
; which is still the same as original one. (person-race) get its name from definition, because
; we called it from there, and then search the table for that name. However, since we changed
; the name in the table, it can not find anything and then gives error.
    		      	
;;; test cases    		      	
    		      	
; (display "Testing Problem 13\n")
;(table-display person-table)
;(set-person-gender! "axe" 'female)
;(table-display person-table)
; (define alyssa (make-person "alyssa-p-hacker" 'black 'female 1978))
;(table-display person-table)
; (set-person-name! alyssa "alyssa-p-hacker-bitdiddle")  ; got married!
; (table-display person-table)
;(person-name "asdksaf")
; (person-name alyssa)
;(person-race "alyssa-p-hacker-bitdiddle")
; (person-race alyssa)    		      	
    		      	
;;; Note: after running the test cases above, please comment out them again.
