 ;;; _EMAIL_    _DATE_
;;;
;;; Comp200 Project 0
;;;
;;; Note: The questions for this project are available at the course website.
;;;   Type all your work and notes in the appropriate sections of this file.
;;;   Please do not delete any of the existing lines.
;;;   Please do not make any modifications after midnight on the due date.
;;;   Semicolon is the Scheme comment character.

; Mertcan Asgun

;_BANNER_
;;; 2.1 Preparing your project material for submission


;_BANNER_
;;; 2.2 Expressions to Evaluate
#lang racket
-37
; Value: -37 
(* 8 9)
; Value: 72
(> 10 9.7)
; Value: #t
(- (if (> 3 4)
       7
       10)
   (/ 16 10))
; Value: 8.4
(* (- 25 10)
   (+ 6 3))
; Value: 135
+
; Value: procedure // +
(define double (lambda (x) (* 2 x)))
double
; Value: procedure // double
(define c 4)
c
; Value: 4
(double c)
; Value: 8
c
; Value: 4
(double (double (+ c 5)))
; Value: 36
(define times-2 double)
(times-2 c)
; Value: 8
(define d c)
(= c d)
; Value: #t
(cond ((>= c 2) d)
      ((= c (- d 5)) (+ c d))
      (else (abs (- c d))))
; Value: 4

;_BANNER_
;;; 2.3 Pretty Printing

(define abs 
  (lambda (a) 
    (if (> a 0) 
        a 
        (- a))))
; If we change the location of some part of code, then we can use tab to bring it back into its indented place.


;_BANNER_
;;; 2.4 Tracing
(require racket/trace)
(define (fun x)
  (if (zero? x)
      1
      (* x (fun (- x 1)))))
(trace fun)
(fun 4)

;>(fun 4)
;> (fun 3)
;> >(fun 2)
;> > (fun 1)
;> > >(fun 0)
;< < <1
;< < 1
;< <2
;< 6
;<24
;24

;_BANNER_
;;; 2.5 Documentation and Administrative Questions
; 1) It can be used to observe the process step by step. If an error occures, it can be easily identified
; upon looking the step which error occured instead of trying to understand the mistake from the code.
; 2) define, lambda, if, cond.
; 3) Scheme doesn't distinguish uppercase and lowercase forms of a letter except within character and string
; constants, in other words Scheme is case-insensitive.