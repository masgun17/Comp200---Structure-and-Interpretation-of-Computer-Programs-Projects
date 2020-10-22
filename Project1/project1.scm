;;; masgun17@ku.edu.tr     Wed Oct 17 13:18:51 2018
;;;    		      	
;;; Comp200 Project 1    		      	
;;;    		      	
;;; Before you start:    		      	
;;;    		      	
;;; * Please read the detailed instructions for this project from the
;;; file project1.pdf available on the course website.
;;;    		      	
;;; * Please read "Project Submission Instructions" carefully and make
;;; sure you understand everything before you start working on your
;;; project in order to avoid problems.
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
;;; When you are done:    		      	
    		      	
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
    		      	
;;; These two lines are necessary, please do not delete:
#lang sicp    		      	
(#%require (only racket/base random))
(define your-answer-here -1)    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;;;::;:;:
;;; Problem 1: Modular Arithmetic
    		      	
 (modulo 13 8) ; ->  5    		      	
 (remainder 13 8) ; ->  5    		      	
 (modulo -13 8) ; ->  3    		      	
 (remainder -13 8) ; ->  -5    		      	
 (modulo -13 -8) ; ->  -5    		      	
 (remainder -13 -8) ; ->  -5


;5
;5
;3
;-5
;-5
;-5
 		      	
;;; What is the difference between remainder and modulo? Which one is
;;; the best choice for implementng modular arithmetic as described in
;;; project pdf?  Include your test results and your answers to these
;;; questions in a comment in your solution.


your-answer-here
; Modulo procedure tries to get the remainder in the sign of given b which is more useful
; for us while implementing modular arithmethic method.
    		      	
    		      	
;;; Description for +mod    		      	
    		      	
(define +mod    		      	
  (lambda (a b n)
    (modulo (+ a b) n)))

; modulo is better for implementing modular arithmethic method, so i will use it.
; In this part I just add given a and b, then find its modulo in n.
; It is a function of three variables(numbers) and it returns only one answer(number).

(+mod 7 5 8) ; -> 4    		      	
(+mod 10 10 3) ; -> 2  
(+mod 99 99 100) ; -> 98          

;4
;2
;98   		      	
    		      	
;;; Description for -mod    		      	
    		      	
    		      	
(define -mod    		      	
  (lambda (a b n)    		      	
    (modulo (- a b) n)))

; Similarly, in this part I just substract b from given a and then find its modulo in
; the base of n. Again, it is a function of three variables, which returns one answer.

(-mod 5 12 2)  ; -> 1

;1 		      	
    		      	
;;; Description for *mod    		      	
    		      	
(define *mod    		      	
  (lambda (a b n)    		      	
    (modulo (* a b) n)))

; Again, just multiply given a and b, then find its modulo in the base of n. It is a function
; of three variables and it returns only one answer.

(*mod 6 6 9) ; -> 0 
(*mod 50 -3 100)  ; -> 50

;0
;50		      	
    		      	
; After the definition of each procedure, please cut and paste some
; test cases you have run, making sure the lines are commented out
; with semi-colons:    		      	
    		      	
; Test cases    		      	
    		      	
;; (+mod 7 5 8) ; -> 4    		      	
;; (+mod 10 10 3) ; -> 2    		      	
;; (-mod 5 12 2) ; -> 1    		      	
;; (*mod 6 6 9) ; -> 0    		      	
;; (+mod 99 99 100) ; ->   98    		      	
;; (*mod 50 -3 100) ; ->   50    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;;;::;::;
;;; Problem 2: Raising a Number to a Power
    		      	
;; What is the order of growth in time of slow-exptmod?
your-answer-here
; At final stage for given k for b, there will be k terms which will be multiplied.
; So its growth in time is n, linear.
    		      	
;; What is its order of growth in space?
your-answer-here
; At each stage it will remember one a value, for given k values it will remember k values.
; So it is again n, linear.
    		      	
;; Does slow-exptmod use an iterative algorithm or a recursive algorithm?
your-answer-here
; At each step, it adds one more a value to multiply at the end. So it is recursive.    	
    		      	
;;; Description for exptmod    		      	
    		      	
(define exptmod
  (lambda (a b n)
    (cond ((= b 0) 1)
          ((= b 1) (modulo a n))
          ((>= b 2)
           (cond ((= (remainder b 2) 0) (modulo (exptmod (*mod a a n) (/ b 2) n) n))
                 ((= (remainder b 2) 1) (modulo (* a (exptmod (*mod a a n) (/ (- b 1) 2) n)) n)))))))

; exptmod procedure takes three variables a, b and n. If b is 0 it returns 1, if b is 1 it returns a modulo n
; and if b is greater than or equal to 2 then it looks for b's remainder first. If it is divisible by two
; it calls exptmod for (a^2), (b/2) and n recursively. If it isn't divisible by 2 than it calls exptmod for
; (a*a^2), (b/2) and n recursively.	      	
    		      	
; Test cases:    		      	
    		      	
(exptmod 2 0 10) ; -> 1    		      	
(exptmod 2 3 10) ; -> 8    		      	
(exptmod 3 4 10) ; -> 1    		      	
(exptmod 2 15 100) ; -> 68    		      	
(exptmod -5 3 100) ; -> 75

;1
;8
;1
;68
;75   		      	
    		      	
; What is the order of growth in time of exptmod?
your-answer-here
; For example, when you enter a value which is the power of 2's for b then the result will only take log b on the base of
; 2 and it is quite efficient. In other circumstances the program divides b to 2 until it reaches an odd number and then
; it substracts one and continues to do the same thing. Though it takes more than log b steps, still it can be considered
; in the form of log n. So the order of growth of time of exptmod is log n, logarithmic.
    		      	
;; What is its order of growth in space?
your-answer-here
; When b reaches to an odd number, it recursively remember one a value and then multiply the result with a at last. So
; we can assume that there will be maximum of log n pending operations even for worst cases. So its growth in space is also
; log n, logarithmic.
    		      	
;; Does exptmod use an iterative algorithm or a recursive algorithm?
your-answer-here
; Since exptmod calls itself repeatedly, it uses a recursive algorithm.    		   	      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;;;::;:::
;;; Problem 3: Large Random Number
    		      	
;;; Examples of random    		      	
;; The results of random will be different for each run so you might not get the
;; below results.    		      	
 (random 10) ; ->1    		      	
 (random 10) ; ->6    		      	
 (random 10) ; ->6    		      	
 (random 10) ; ->0    		      	
 (random 10) ; ->7    		      	

;4
;8
;8
;8
;1		      	
    		      	
;;; Description for random-k-digit-number:
    		      	
(define exp
  (lambda (a b)
    (cond ((= b 0) 1)
          ((= b 1) a)
          ((>= b 2)
           (cond ((= (remainder b 2) 0) (exp (* a a) (/ b 2)))
                 ((= (remainder b 2) 1) (* a (exp (* a a) (/ (- b 1) 2)))))))))

(define random-k-digit-number
  (lambda (n)
    (if (= n 0)
        0
        (+ (* (random 10) (exp 10 (- n 1))) (random-k-digit-number (- n 1))))))
       
; Before writing a procedure for random-k-digit-number, I created another method called exp. It does the same
; thing as exptmod, instead of this procedure doesn't take any n value and it only calculates the exponential
; of a number, not modulus.
; random-k-digit-number takes a n value which determines the maximum number of digits for our random number.
; If n is 0, basically it returns 0. For any other n values, it multiplies 10^(n-1) with a random number between
; 0 and 10, 0 included, and then it calls itself for (n-1) recursively.		      	
    		      	
; Test cases:    		      	
    		      	
 (random-k-digit-number 1) ; ->  ?  (1 digit)
 (random-k-digit-number 3) ; ->  ?  (1-3 digits)
 (random-k-digit-number 3) ; ->  ?  (is it different?)
 (random-k-digit-number 50) ; ->  ?  (1-50 digits)

;4
;876
;921
;78896501170388604250766433557780230354367800026897
    		      	
;;; Description for count-digits
    		      	
(define count-digits    		      	
  (lambda (n)
    (define helper
      (lambda (n k)
        (if (< n 1)
            k
            (helper (/ n 10) (+ k 1)))))
    (helper n 0)))	      	

; count-digits procedure takes one variable, number and it returns its digit number. To do this it defines a helper
; method in itself. This helper consists of two variables, n and k, counter. while n is greater than 1 it divides
; it with 10 and increases the counter once. So it does this until n becomes something between 0 and 1. At last it
; returns k, counter value.

; Test cases:    		      	
    		      	
 (count-digits 3) ; -> 1    		      	
 (count-digits 2007) ; -> 4    		      	
 (count-digits 123456789) ; -> 9

;1
;4
;9
    		      	
;;; Description for big-random    		      	
    		      	
(define big-random    		      	
  (lambda (n)
    (let ((j (random-k-digit-number (count-digits n))))
      (if (and (< j n) (>= j 0))
          j
          (big-random n)))))	      	

; big-random takes an integer n and generates a random integer lesser than n. To do this, first it looks for
; the digit number of n by count-digits. Then it creates a random number with same digit number and assigns
; it to j. If j is lesser than n it returns it, else it generates new random number again.


; Test cases:    		      	
 (big-random 100) ; ->  10  (1-2 digit number)
 (big-random 100) ; ->  9  (is it different?) // Yes
 (big-random 1) ; ->  0    		      	
 (big-random 1) ; ->  0 (should be always 0)
 (big-random (expt 10 40)) ; ->  9182066439136278740494965641138504208745  (roughly 40-digit number)

;24
;97
;0
;0
;1108895413335611832381792705621331718443
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;;;:::;;;
;;; Problem 4: Prime Numbers    		      	
    		      	
;;; What is the order of growth in time of slow-prime? ?
your-answer-here    		      	
; It is n, linear.
;;; What is its order of growth in space?
your-answer-here    		      	
; It is 1, constant.    		      	
;;; Does slow-prime? use an iterative algorithm or a recursive algorithm?
your-answer-here    		      	
; Recursive, because it calls itself repeatedly.  		      	
;;; We only have to check factors less than or equal to (sqrt n). How would this
;;; affect the order of growth in time?
your-answer-here    		      	
; It speeds up the calculation quite a lot, O(n^(1/2)), which is polynomial.    		      	
;;; We only have to check odd factors (and 2, as a special case). How would this
;;; affect the order of growth in time?
your-answer-here    		      	
; it decreases the number we have to check to half. So O(n/2), which is also linear.    		      	

;;; Test Fermat's Little Theorem
(exptmod 10 97 97)		      	
(exptmod 5 7 7)   		      	
;10
;5		      	
    		      	
;;; Description for prime?    		      	
    		      	
(define prime-test-iterations 20)

(define prime?
  (lambda (p)
    (cond ((= p 1) #f)
          ((= p 0) #f)
          (else (prime-helper p 1)))))

(define prime-helper
  (lambda (p c)
    (let ((u (big-random p)))
      (if  (= (exptmod u p p) u)
           (if (= c prime-test-iterations)
               #t
               (prime-helper p (+ c 1)))
           #f))))	

; prime procedure consists an helper method. If given number equals to 0 or 1 it returns #f, else it calls helper
; method. Helper method consists two variables, one is given number and second is counter c. First it creates a
; random number less than p and then applies Fermat's Little Theorem to it. If it is not successful it returns
; #f. If it is true it increases counter by one and repeat this again until counter reaches prime-test-iterations.


; Test cases:    		      	
 (prime? 2) ; -> #t    		      	
 (prime? 4) ; -> #f    		      	
 (prime? 1) ; -> #f    		      	
 (prime? 0) ; -> #f    		      	
 (prime? 200) ; -> #f    		      	
 (prime? 199) ; -> #t
;#t
;#f
;#f
;#f
;#f
;#t 		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;;;:::;;:
;;; Problem 5: Random Primes    		      	
    		      	
;;; Description for random-prime:
    		      	
(define random-prime
  (lambda (n)
    (let ((k (big-random n)))
      (if (prime? k)
          k
          (random-prime n)))))	      	

; Test cases:    		      	
 (random-prime 3) ; -> 2    		      	
 (random-prime 3) ; -> 2 (must be always 2)
 (random-prime 100) ; ->  ?   		      	
 (random-prime 100) ; ->  ? (is it different?) Yes  		      	
 (random-prime 100000) ; ->  ?

;2
;2
;11
;59
;28807
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;:;::;;;;
;;; Problem 6: Multiplicative Inverses
    		      	
;;; Description of ax+by=1    		      	
    		      	
(define ax+by=1
  (lambda (a b)
    (if (= 1 (remainder a b))
        (list 1 (* -1 (quotient a b)))
        (let ((nextAB (ax+by=1 b (remainder a b))))
          (list (cadr nextAB) (- (car nextAB) (* (cadr nextAB) (quotient a b))))))))
	      	
; This procedure uses Euclidean Algorithm. If remainder of given a and b is equal to 1 it creates a list
; with corresponding x and y value. If it is not equal to 1 then it looks for remainders of b and (remainder a b).
; At each step it modifies the set and when remainder reaches 1 it applies all modifications to the original list.


; Test cases    		      	
 (ax+by=1 17 13) ; -> (-3 4) 17*-3 + 13*4 = 1
 (ax+by=1 7 3) ; -> (1 -2) 7*1 + 3*-2 =1
 (ax+by=1 10 27) ; -> (-8 3) 10*-8 + 3*27 =1

;(mcons -3 (mcons 4 '()))
;(mcons 1 (mcons -2 '()))
;(mcons -8 (mcons 3 '()))
    		      	
;;; Description of inverse-mod    		      	
    		      	
(define inverse-mod
  (lambda (e n)
    (if (= 1 (gcd e n))
        (modulo (car (ax+by=1 e n)) n)
        (display "They are not relatively prime"))))

; This procedure takes two integers, one is for e and one is for modulo. If their gcd is 1, it calculates their
; solution set for ax+by=1 from same named procedure above and then takes its first value, x and takes its modulo
; on n.

    		      	
; Test cases:    		      	
 (inverse-mod 5 11) ; ->9 5*9 = 45 = 1 (mod 11)
 (inverse-mod 9 11) ; -> 5    		      	
 (inverse-mod 7 11) ; -> 8 7*8 = 56 = 1 (mod 11)
 (inverse-mod 8 12) ; -> error no inverse exists
 (inverse-mod (random-prime 101) 101) ;-> (test your answer with *mod)  ? 

;9
;5
;8
;They are not relatively prime34 ; It represent the answer of the last test here.

    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;:;::;;;:
;;; Problem 7: RSA    		      	
    		      	
;;; Description of random-keypair
(define (make-key exp mod)
  (list exp mod))

; make-key creates a list with 2 variables in it. 1 key and 1 modulo n, respectively.

(define (get-exponent key)
  (car key))

; get-exponent takes the first item in the "key", which is public or private key.

(define (get-modulus key)
  (cadr key))

; get-modulus takes the second item in the list, which is n. 

(define random-keypair
  (lambda (m)
    (let ((p (random-prime m)) (q (random-prime m)))
      (let ((n (* p q)))
        (let ((e (big-random n)))
      (if (and (= 1 (gcd e (- p 1) (- q 1))) (= 1 (gcd e (* (- p 1) (- q 1)))) (> e 0)) ; I added (> e 0) part because in one of my runs, it generated e as 0, so it stopped in inverse-mod where it tries to ...
          (list (make-key e n) (make-key (inverse-mod e (* (- p 1) (- q 1))) n))        ; calculate ax+by=1 where a is 0. It is not logical since x can take any value when a is zero.
          (random-keypair m)))))))
    		      	
; First I randomly generated two prime numbers and then assigned them to p and q. Then I assigned their
; multiplication to n. Then I generated a random number, smaller than n and assigned it to e, which
; is my first key, probably. If gcd's of e, p-1 and q-1 equal to 1 and gcd's of e and (p-1)*(q-1) equal to
; 1 (it is because of my next step, where i get the inverse mod of e and (p-1)*(q-1). To avoid error message
; caused by their gdc's being different from 1, I check their gcd at the start). If the conditions provided
; then I will assign e value as public key, inverse mod of e and (p-1)*(q-1) as d, private key and at last I will
; assign n, which will be used for modulo. Then I created a list with two lists in it. First is e and n, second
; is d and n. If conditions are not provided, then it will randomly create another e value and do the same things.

    		      	
;;; Description of random-keypair

(define rsa
  (lambda (key message)
    (exptmod message (get-exponent key) (get-modulus key))))
; rsa takes two variables, one key and one message. Message is a random sequence of number, for now. This procedure
; takes this message and calculates its power to the first-key, e, which is accessible with get-exponent procedure.
; And calculates its value in modulo n, which is accessible with get-modulus procedure..

    		      	
; Test cases:    		      	
;(rsa (car key) 213871683819)
;1987007778884186075599600255493106006235720567671
;(rsa (cadr key) 1987007778884186075599600255493106006235720567671)
;213871683819

;(rsa (car key) 123)
;3511763022632912971186839247592276401146727169533
;(rsa (cadr key) 3511763022632912971186839247592276401146727169533)
;123

;;; What happend when you try to encrypt and decrypt a message integer
;;;which is too large for the key - i.e., larger than the modulus n?
your-answer-here
; It printed wrong and meaningles sequence.
;"åÇ¾<4±¼5\u0098\a\u0097*\apÞ\u0092\u0093áî1\u0000J]´xö_äÒö\u001Eß6µñ\u009Bxx\u009B9æ\u0095\u0001\u0015í¬¯\u0014"    	
    		      	
;;; Description of encrypt:    		      	

(define encrypt
  (lambda (public-key string)
    (rsa public-key (string->integer string))))



; It takes key, string message. It converts string into a number sequence and then calls rsa to encrypt the message.
; Then rsa takes the number sequence and calculates the value using key and modulo n.  	
    		      	
;;; Description of encrypt:    		      	
    		      	
(define decrypt
  (lambda (private-key encrypted-message)
    (integer->string
     (rsa private-key encrypted-message))))
; It takes key and the encrypted message, which is derived from encrypt procedure. Then it calls rsa procedure
; to encode the number sequence. Then decrypt takes this value and turns it into string.
    		      	
;; Test cases:   I COPIED THOSE TEST TO THE END OF THE PROJECT 		      	
;(define key (random-keypair 10000000000000000000000000))
;(define e1 (encrypt (car key) "hello Comp200!"))
;(decrypt (cadr key) e1) ; -> "hello Comp200!"
    		      	
;; (define e2 (encrypt (car key) ""))
;; (decrypt (cadr key) e2) ; -> ""
    		      	
;; (define e3 (encrypt (car key) "This is fun!"))
;; (decrypt (cadr key) e3) ; -> "This is fun!"
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:;:;::;;;:;::;;:;
;; Helper functions: you do not need to edit the functions given below.
    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    		      	
;; Problem 2: Raising a Number to a Power
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
(define slow-exptmod    		      	
  (lambda (a b n)    		      	
    (if (= b 0)    		      	
	1    		      	
	(*mod a (slow-exptmod a (- b 1) n) n))))
    		      	
    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    		      	
;; Problem 4: Prime Numbers    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
(define test-factors    		      	
  (lambda (n k)    		      	
    (cond ((>= k n) #t)    		      	
	  ((= (remainder n k) 0) #f)
	  (else (test-factors n (+ k 1))))))
    		      	
(define slow-prime?    		      	
  (lambda (n)    		      	
    (if (< n 2)    		      	
	#f    		      	
	(test-factors n 2))))    		      	
    		      	
    		      	
    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    		      	
;; Problem 7: RSA    		      	
;;    		      	
;; Converting message strings to and from
;; integers.    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
    		      	
(define (join-numbers list radix)
  ; Takes a list of numbers (i_0 i_1 i_2 ... i_k)
  ; and returns the number    		      	
  ;    n = i_0 + i_1*radix + i_2*radix2 + ... i_k*radix^k + radix^(k+1)
  ; The last term creates a leading 1, which allows us to distinguish
  ; between lists with trailing zeros.
  (if (null? list)    		      	
      1    		      	
      (+ (car list) (* radix (join-numbers (cdr list) radix)))))
    		      	
; test cases    		      	
(join-numbers '(3 20 39 48) 100) ;-> 148392003
(join-numbers '(5 2 3 5 1 9) 10) ;-> 1915325
(join-numbers '() 10) ;-> 1

;148392003
;1915325
;1
    		      	
    		      	
(define (split-number n radix)    		      	
  ; Inverse of join-numbers.  Takes a number n generated by
  ; join-numbers and converts it to a list (i_0 i_1 i_2 ... i_k) such
  ; that    		      	
  ;    n = i_0 + i_1*radix + i_2*radix2 + ... i_k*radix^k + radix^(k+1)
  (if (<= n 1)    		      	
      '()    		      	
      (cons (remainder n radix)
            (split-number (quotient n radix) radix))))
    		      	
; test cases    		      	
(split-number (join-numbers '(3 20 39 48) 100) 100) ;-> (3 20 39 48)
(split-number (join-numbers '(5 2 3 5 1 9) 10) 10)  ;-> (5 2 3 5 1 9)
(split-number (join-numbers '() 10) 10) ; -> ()

;(mcons 3 (mcons 20 (mcons 39 (mcons 48 '()))))
;(mcons 5 (mcons 2 (mcons 3 (mcons 5 (mcons 1 (mcons 9 '()))))))
;'()
    		      	
(define chars->bytes    		      	
  ; Takes a list of 16-bit Unicode characters (or 8-bit ASCII
  ; characters) and returns a list of bytes (numbers in the range
  ; [0,255]).  Characters whose code value is greater than 255 are
  ; encoded as a three-byte sequence, 255 <low byte> <high byte>.
  (lambda (chars)    		      	
    (if (null? chars)    		      	
        '()    		      	
        (let ((c (char->integer (car chars))))
          (if (< c 255)    		      	
              (cons c (chars->bytes (cdr chars)))
              (let ((lowbyte (remainder c 256))
                    (highbyte  (quotient c 256)))
                (cons 255 (cons lowbyte (cons highbyte (chars->bytes (cdr chars)))))))))))
    		      	
; test cases    		      	
(chars->bytes (string->list "hello")) ; -> (104 101 108 108 111)
(chars->bytes (string->list "\u0000\u0000\u0000")) ; -> (0 0 0)
(chars->bytes (string->list "\u3293\u5953\uabab")) ; -> (255 147 50 255 83 89 255 171 171)

;(mcons 104 (mcons 101 (mcons 108 (mcons 108 (mcons 111 '())))))
;(mcons 0 (mcons 0 (mcons 0 '())))
;(mcons 255 (mcons 147 (mcons 50 (mcons 255 (mcons 83 (mcons 89 (mcons 255 (mcons 171 (mcons 171 '())))))))))
    		      	
    		      	
(define bytes->chars    		      	
  ; Inverse of chars->bytes.  Takes a list of integers that encodes a
  ; sequence of characters, and returns the corresponding list of
  ; characters.  Integers less than 255 are converted directly to the
  ; corresponding ASCII character, and sequences of 255 <low-byte>
  ; <high-byte> are converted to a 16-bit Unicode character.
  (lambda (bytes)    		      	
    (if (null? bytes)    		      	
        '()    		      	
        (let ((b (car bytes)))    		      	
          (if (< b 255)    		      	
              (cons (integer->char b)
                    (bytes->chars (cdr bytes)))
              (let ((lowbyte (cadr bytes))
                    (highbyte (caddr bytes)))
                (cons (integer->char (+ lowbyte (* highbyte 256)))
                      (bytes->chars (cdddr bytes)))))))))
    		      	
; test cases    		      	
(bytes->chars '(104 101 108 108 111)) ; -> (#\h #\e #\l #\l #\o)
(bytes->chars '(255 147 50 255 83 89 255 171 171)) ; -> (#\u3293 #\u5953 #\uabab)

;(mcons #\h (mcons #\e (mcons #\l (mcons #\l (mcons #\o '())))))
;(mcons #\㊓ (mcons #\奓 (mcons #\uABAB '())))
    		      	
    		      	
    		      	
(define (string->integer string)
  ; returns an integer representation of an arbitrary string.
  (join-numbers (chars->bytes (string->list string)) 256))
    		      	
; test cases    		      	
(string->integer "hello, world")
(string->integer "")    		      	
(string->integer "April is the cruelest month")
(string->integer "\u0000\u0000\u0000")

;110307767890868773485045114216
;1
;148282508185397828465160297964451103928119023808845883709305548865
;16777216
    		      	
(define (integer->string integer)
  ; inverse of string->integer.  Returns the string corresponding to
  ; an integer produced by string->integer.
  (list->string (bytes->chars (split-number integer 256))))
    		      	
; test cases    		      	
(integer->string (string->integer "hello, world"))
(integer->string (string->integer ""))
(integer->string (string->integer "April is the cruelest month"))
(integer->string (string->integer "\u0000\u0000\u0000"))
(integer->string (string->integer "\u3293\u5953\uabab"))

;"hello, world"
;""
;"April is the cruelest month"
;"\u0000\u0000\u0000"
;"㊓奓\uABAB"

(define key (random-keypair 10000000000000000000000000))
(define e1 (encrypt (car key) "hello Comp200!"))
(decrypt (cadr key) e1) ; -> "hello Comp200!"
    		      	
(define e2 (encrypt (car key) ""))
(decrypt (cadr key) e2) ; -> ""
    		      	
(define e3 (encrypt (car key) "This is fun!"))
(decrypt (cadr key) e3) ; -> "This is fun!"

;"hello Comp200!"
;""
;"This is fun!"


; Test Cases

(modulo -7 2)
;1
(remainder -7 2)
;-1
(*mod 7 5 2)
;1
(exptmod 45445 56 87)
;1
(random-k-digit-number 5)
;63428
(random-k-digit-number 0)
;0
(random-k-digit-number 88)
;3942942279423910083172506580819868707579056515467831942769588461106699281746933353601531
(count-digits (random-k-digit-number 88))
;88
(big-random 110)
;38
(big-random (random-k-digit-number 88))
;8321588136777549931182432293617060708961329199128291427070379128925728664965968942261439
(big-random (count-digits (random-k-digit-number 88)))
;9
(prime? (big-random (count-digits (random-k-digit-number 88))))
;#f
(prime? (big-random 129380))
#t
(random-prime (big-random (random-k-digit-number 48)))
;930580480619267486100196945140889743950479361
(ax+by=1 123 32)
;(mcons -13 (mcons 50 '()))
(inverse-mod 123 124)
;123
(random-keypair 100)
;(mcons (mcons 59 (mcons 1577 '())) (mcons (mcons 1451 (mcons 1577 '())) '()))
(rsa (car key) 1987293749872923)
;7838008321717403569755571310129389072460521279584
(rsa (cadr key) (rsa (car key) 1987293749872923)) 
;1987293749872923
(decrypt (cadr key) (encrypt (car key) "qqqqqqq"))
;"qqqqqqq"
(define key2 (random-keypair 10000000000000000000000000000000000000000000000000000000000))
(decrypt (cadr key2) (encrypt (car key2) "I think it is enough."))
;"I think it is enough."
(decrypt (cadr key) (encrypt (car key) "Is it true"))
;"Is it true"
(decrypt (cadr key2) (encrypt (car key2) ":ÇX!'"))
;":ÇX!'"
(decrypt (cadr key2) (encrypt (car key2) "âsfert"))
;"âsfert"
(decrypt (cadr key2) (encrypt (car key2) "bvbsdgseteqwewopaıdo"))
;"bvbsdgseteqwewopaıdo"
(decrypt (cadr key2) (encrypt (car key2) "9123884rnejnk81uASDfw2"))
;"9123884rnejnk81uASDfw2"
(decrypt (cadr key2) (encrypt (car key2) "This message will be to long........................................................................................................................................................."))
;It gives an error(wrong-random sequence), since the string is very long for given keypair.
;"åÇ¾<4±¼5\u0098\a\u0097*\apÞ\u0092\u0093áî1\u0000J]´xö_äÒö\u001Eß6µñ\u009Bxx\u009B9æ\u0095\u0001\u0015í¬¯\u0014"
