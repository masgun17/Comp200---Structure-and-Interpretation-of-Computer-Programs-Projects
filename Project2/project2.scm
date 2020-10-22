;;; masgun17@ku.edu.tr    Fri Nov  2 15:55:11 2018
;;;    		      	
;;; Comp200 Project 2    		      	
;;;    		      	
;;;    		      	
;;; Before you start:    		      	
;;;    		      	
;;; * Please read the detailed instructions for this project from the
;;; file project2.pdf available on the course website.
;;;    		      	
;;; * Please read "Instructions" carefully and make
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
;;; * Remember our collaboration policy: you can discuss with your friends but
;;;    		      	
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;    		      	
;;; When you are done:    		      	
;;; * Perform a final save and check-in.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email comp200@ku.edu.tr if you have any questions.
;;; * Make sure your file loads and runs without errors.
;;;    		      	
;;;   *** IF (load "project2.scm") GIVES ERRORS OR WE CANNOT RUN YOUR PROJECT, IT WILL NOT BE GRADED ***
;;;    		      	
    		      	
;;; DO NOT CHANGE FOLLOWING LINES, THEY ARE NECESSARY FOR THE WHOLE PROJECT.
;;; WHILE SOLVING PROBLEMS YOU CAN USE THE PROCEDURES DEFINED HERE, IT WILL EASE YOUR WORK.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lang racket    		      	
(require math/bigfloat)
; Ignore the following. This is necessary so the file loads without errors initially:
(define your-answer-here #f)    		      	
    		      	
; make-play will make a list then given two strings
; e.g. (make-play "c" "c") => ("c" "c")
(define make-play list)    		      	
    		      	
; The empty history when noone    		      	
; has started to played yet    		      	
(define the-empty-history '())    		      	
    		      	
; extend-history adds the new element
; to the history when someone plays
(define extend-history cons)    		      	
    		      	
; empty-history? is a procedure that
; returns boolean true if the history is empty
(define empty-history? null?)    		      	
    		      	
; History of players is kept in a list.
; The last action is found by most-recent-play procedure.
(define most-recent-play car)    		      	
    		      	
; All the actions except the most recent
; one are found with rest-of-plays procedure.
(define rest-of-plays cdr)    		      	
    		      	
; The play-loop procedure takes as its  arguments two prisoner's
; dilemma strategies, and plays an iterated game of approximately
; one hundred rounds.  A strategy is a procedure that takes
; two arguments: a history of the player's previous plays and
; a history of the other player's previous plays.  The procedure
; returns either a "c" for cooperate or a "d" for defect.
(define (play-loop strat0 strat1)
  (define (play-loop-iter strat0 strat1 count history0 history1 limit)
    (cond ((= count limit) (print-out-results history0 history1 limit))
          (else (let ((result0 (strat0 history0 history1))
                      (result1 (strat1 history1 history0)))
                  (play-loop-iter strat0 strat1 (+ count 1)
                                  (extend-history result0 history0)
                                  (extend-history result1 history1)
                                  limit)))))
  (play-loop-iter strat0 strat1 0 the-empty-history the-empty-history
                  (+ 90 (random 21))))
    		      	
; The following procedures are used to compute and print
; out the players' scores at the end of an iterated game
(define (print-out-results history0 history1 number-of-games)
  (let ((scores (get-scores history0 history1)))
    (newline)    		      	
    (display "Player 1 Score:  ")
    (display (* 1.0 (/ (car scores) number-of-games)))
    (newline)    		      	
    (display "Player 2 Score:  ")
    (display (* 1.0 (/ (cadr scores) number-of-games)))
    (newline)))    		      	
    		      	
(define (get-scores history0 history1)
  (define (get-scores-helper history0 history1 score0 score1)
    (cond ((empty-history? history0)
           (list score0 score1))
          (else (let ((game (make-play (most-recent-play history0)
                                       (most-recent-play history1))))
                  (get-scores-helper (rest-of-plays history0)
                                     (rest-of-plays history1)
                                     (+ (get-player-points 0 game) score0)
                                     (+ (get-player-points 1 game) score1))))))
  (get-scores-helper history0 history1 0 0))
    		      	
(define (get-player-points num game)
  (list-ref (get-point-list game) num))
    		      	
(define *game-association-list*
  ;; format is that first sublist identifies the players' choices
  ;; with "c" for cooperate and "d" for defect; and that second sublist
  ;; specifies payout for each player
  '((("c" "c") (3 3))    		      	
    (("c" "d") (0 5))    		      	
    (("d" "c") (5 0))    		      	
    (("d" "d") (1 1))))    		      	
    		      	
; Note that you will need to write extract-entry in Problem 1
(define (get-point-list game)    		      	
  (cadr (extract-entry game *game-association-list*)))
    		      	
; A sampler of strategies    		      	
    		      	
(define (NASTY my-history other-history)
  "d")    		      	
    		      	
(define (PATSY my-history other-history)
  "c")    		      	
    		      	
(define (SPASTIC my-history other-history)
  (if (= (random 2) 0)    		      	
      "c"    		      	
      "d"))    		      	
    		      	
(define (EGALITARIAN  my-history other-history)
  (define (count-instances-of test hist)
    (cond ((empty-history? hist) 0)
          ((string=? (most-recent-play hist) test)
           (+ (count-instances-of test (rest-of-plays hist)) 1))
          (else (count-instances-of test (rest-of-plays hist)))))
  (let ((ds (count-instances-of "d" other-history))
        (cs (count-instances-of "c" other-history)))
    (if (> ds cs) "d" "c")))    		      	
    		      	
(define (EYE-FOR-EYE my-history other-history)
  (if (empty-history? my-history)
      "c"    		      	
      (most-recent-play other-history)))
;;; DO NOT CHANGE THE ABOVE LINES, THEY ARE NECESSARY FOR THE WHOLE PROJECT.
;;; WHILE SOLVING PROBLEMS YOU CAN USE THE PROCEDURES DEFINED HERE, IT WILL EASE YOUR WORK.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;::;;:::;;:;::;:;;
;;; Problem 1    		      	
    		      	
; Description for extract-entry: (before the definition of each procedure,
; please write a description about what the procedure does and what
; its input and output should be, making sure the lines are commented
; out with semi-colons)    		      	
    		      	
; HINT: You can make use of list-ref
; (list-ref *game-association-list* 0) ==> (("c" "c") (3 3))
; (list-ref *game-association-list* 1) ==> (("c" "d") (0 5))

; extract-entry takes two inputs, first one is the play which represents the datas in the
; list form. Second one is *game-association-list*, which is defined above. This procedure
; evaluates the first input, play, and then returns the correct list from *game-association-list*. 
    		      	
(define (extract-entry play *game-association-list*)
  (cond ( (equal? play (car (list-ref *game-association-list* 0))) (list-ref *game-association-list* 0))
        ( (equal? play (car (list-ref *game-association-list* 1))) (list-ref *game-association-list* 1))
        ( (equal? play (car (list-ref *game-association-list* 2))) (list-ref *game-association-list* 2))
        ( (equal? play (car (list-ref *game-association-list* 3))) (list-ref *game-association-list* 3))
        (else '())))    		      	
    		      	
; Test cases for extract-entry: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 1--------")
(newline)    		      	
(define a-play (make-play "c" "c"))
(extract-entry a-play *game-association-list*) ; ANSWER => '(("c" "c") (3 3))
    		      	
(define a2-play (make-play "c" "d"))
(extract-entry a2-play *game-association-list*) ; ANSWER => '(("c" "d") (0 5))
    		      	
(define a3-play (make-play "d" "c"))
(extract-entry a3-play *game-association-list*) ; ANSWER => '(("d" "c") (5 0))
    		      	
(define a4-play (make-play "d" "d"))
(extract-entry a4-play *game-association-list*) ; ANSWER => '(("d" "d") (1 1))
    		      	
(define a5-play (make-play "x" "x"))
(extract-entry a5-play *game-association-list*) ; ANSWER => '()
(display "-----End of Problem 1-----")
(newline)

;'(("c" "c") (3 3))
;'(("c" "d") (0 5))
;'(("d" "c") (5 0))
;'(("d" "d") (1 1))
;'()
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;::;;:::;;:;::;:;:
;;; Problem 2    		      	
    		      	
; Use play-loop to play games among the five defined strategies
; Create a matrix in which you show the average score for
; tournaments pitting all possible pairings of the five
; different strategies: Nasty, Patsy, Eye-for-Eye, Spastic, Egalitarian.
; Describe the behavior you observe for the different strategies.

; To test the strategies against each other => e.g. (play-loop NASTY PATSY)
; Fill in the ? part in below matrices when you get the result from play-loop procedure.
    		      	
; Strategy2 =>      NASTY       ||       PATSY       ||                SPASTIC                  ||               EGALITARIAN              ||              EYE-FOR-EYE                ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Strategy1 | Player1 | Player2 || Player1 | Player2 ||       Player1     |         Player2     ||      Player1      |      Player2       ||      Player1       |       Player2      ||
;           | points  | points  || points  | points  ||       points      |         points      ||      points       |      points        ||      points        |       points       ||
;  NASTY    |   1.0   |   1.0   ||   5.0   |   0     || 3.05607476635514  | 0.48598130841121495 || 1.0363636363636364|  0.990909090909091 || 1.0404040404040404 | 0.9895833333333334 ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
; Strategy2 =>      NASTY       ||       PATSY       ||                SPASTIC                  ||               EGALITARIAN              ||              EYE-FOR-EYE                ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Strategy1 | Player1 | Player2 || Player1 | Player2 ||       Player1     |         Player2     ||      Player1      |      Player2       ||      Player1       |       Player2      ||
;           | points  | points  || points  | points  ||       points      |         points      ||      points       |      points        ||      points        |       points       ||
;  PATSY    |   0     |   5.0   ||   3.0   |   3.0   || 1.669811320754717 |  3.8867924528301887 ||        3.0        |        3.0         ||       3.0          |        3.0         ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
; Strategy2 =>                 NASTY                 ||                  PATSY                  ||                SPASTIC                  ||               EGALITARIAN              ||              EYE-FOR-EYE                ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Strategy1 |      Player1       |       Player2     ||      Player1       |       Player2      ||       Player1      |         Player2     ||      Player1      |      Player2       ||      Player1       |       Player2      ||
;           |      points        |       points      ||      points        |       points       ||       points       |         points      ||      points       |      points        ||      points        |       points       ||
;  SPASTIC  | 0.5094339622641509 | 2.9622641509433962|| 3.9622641509433962 | 1.5566037735849056 ||  2.323809523809524 | 2.1333333333333333  || 3.233009708737864 | 2.0679611650485437 || 2.3404255319148937 | 2.3404255319148937 ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
; Strategy2 =>                 NASTY                  ||                  PATSY                  ||                SPASTIC                   ||               EGALITARIAN              ||              EYE-FOR-EYE                ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Strategy1  |      Player1       |       Player2     ||      Player1       |       Player2      ||       Player1      |         Player2     ||      Player1      |      Player2       ||      Player1       |       Player2      ||
;            |      points        |       points      ||      points        |       points       ||       points       |         points      ||      points       |      points        ||      points        |       points       ||
; EGALITARIAN| 0.9893617021276596 | 1.0425531914893618||       3.0          |        3.0         || 1.8431372549019607 | 3.3627450980392157  ||       3.0         |       3.0          ||        3.0         |       3.0          ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
;  Strategy2 =>                 NASTY                 ||                  PATSY                  ||                SPASTIC                   ||               EGALITARIAN              ||              EYE-FOR-EYE                ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Strategy1  |      Player1       |       Player2     ||      Player1       |       Player2      ||       Player1      |         Player2     ||      Player1      |      Player2       ||      Player1       |       Player2      ||
;            |      points        |       points      ||      points        |       points       ||       points       |         points      ||      points       |      points        ||      points        |       points       ||
; EYE-FOR-EYE| 0.9904761904761905 | 1.0380952380952382||       3.0          |        3.0         || 2.1941747572815533 | 2.2427184466019416  ||       3.0         |       3.0          ||        3.0         |       3.0          ||
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; SPASTIC - EGALITARIAN -> There is not a dominant one, each trial the winner can change,
; one can be defeated badly in one trial but then it can beat the other one by far.
; SPASTIC - EYE-FOR-EYE -> Equal, most of the time.
; EGALITARIAN - SPASTIC -> Not certain winner, maight change each trial.
; NASTY - PATSY -> Same results, always.
; NASTY, does not lose generally.
; PATSY, does not win generally.
; EYE-FOR-EYE, does not win generally.

;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;::;;:::;;:;::;::;
;;; Problem 3    		      	
    		      	
; Games involving Egalitarian tend to be slower than other games.
; Why is that so? Use order-of-growth notation to explain your answer.

; It calls itself on "else" part repeatedly, so for any given n, it repeats itself n times.
; And it repeats this for both c and d. So it takes 2n steps, which can be represented as
; R(n), linear.


; Alyssa P. Hacker, upon seeing the code for Egalitarian,
; suggested the following iterative version of the procedure:
;(define (Egalitarian my-history other-history)
;  (define (majority-loop cs ds hist)
;    (cond ((empty-history? hist) (if (> ds cs) “d” “c”))
;          ((string=? (most-recent-play hist) “c”)
;           (majority-loop (+ 1 cs) ds (rest-of-plays hist)))
;          (else    		      	
;           (majority-loop cs (+ 1 ds) (rest-of-plays hist)))))
;  (majority-loop 0 0 other-history))

; Compare this procedure with the original version.
; - In first procedure for every string value in the other-history it checks firstly, whether is it c 
; or not. If it is c, it adds 1 to cs. Then similarly it checks it for d. If it is d, it add 1 to ds.
; At last it compares the numbers cs and ds and then returns the max of c and d.
; In second procedure it checks whether the first item in hist is c or d and then add it
; cs or ds respectively. When hist becomes empty, it returns the max of cs or ds.

; Do the orders of growth (in time) for the two procedures differ?
; - However, the second procedure only takes n steps, still its order of growth is R(n), same as
; first procedure.

; Is the newer version faster?    		      	
; ANSWER:  Yes.  		      	
;    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;::;;:::;;:;::;:::
;;; Problem 4    		      	
    		      	
; Write a new strategy eye-for-two-eyes

; It takes two inputs, two histories. If there are less than 2 data in other-history it gives "c".
; If not then it looks the last 2 input of the other-history(last added, newest). If both of them
; is "d" it prints "d", otherwise it prints "c".

(define (EYE-FOR-TWO-EYES my-history other-history)
  (cond ((empty-history? other-history) "c")
        ((empty-history? (rest-of-plays other-history)) "c")
        ((and (equal? (most-recent-play other-history) "d")
              (equal? (most-recent-play (rest-of-plays other-history)) "d"))
         "d")
        (else "c")))   		      	
        	      	
    		      	
; Test cases for EYE-FOR-TWO-EYES: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 4--------")
(newline)    		      	
    		      	
; Strategy depends only to the other-history, so dont case my-history
(EYE-FOR-TWO-EYES the-empty-history the-empty-history) ; ANSWER => "c"
(EYE-FOR-TWO-EYES the-empty-history (list "c")) ; ANSWER => c"
(EYE-FOR-TWO-EYES the-empty-history (list "d")) ; ANSWER => "c"
(EYE-FOR-TWO-EYES the-empty-history (list "c" "c")) ; ANSWER => "c"
(EYE-FOR-TWO-EYES the-empty-history (list "c" "d")) ; ANSWER => "c"
(EYE-FOR-TWO-EYES the-empty-history (list "d" "c")) ; ANSWER => "c"
(EYE-FOR-TWO-EYES the-empty-history (list "d" "d")) ; ANSWER => "d"
(EYE-FOR-TWO-EYES the-empty-history (list "c" "d" "c")) ; ANSWER => "c"
(EYE-FOR-TWO-EYES the-empty-history (list "d" "d" "c")) ; ANSWER => "d"
(EYE-FOR-TWO-EYES the-empty-history (list "d" "c" "d" "d")) ; ANSWER => "c"

(display "--------Additional Test Cases for Problem 4--------")

(play-loop EYE-FOR-TWO-EYES NASTY)
;Player 1 Score:  0.9795918367346939
;Player 2 Score:  1.0816326530612246
;
(play-loop EYE-FOR-TWO-EYES PATSY)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop EYE-FOR-TWO-EYES SPASTIC)
;Player 1 Score:  1.8611111111111112
;Player 2 Score:  3.111111111111111
;
(play-loop EYE-FOR-TWO-EYES EGALITARIAN)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop EYE-FOR-TWO-EYES EYE-FOR-EYE)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop EYE-FOR-TWO-EYES EYE-FOR-TWO-EYES)
;Player 1 Score:  3.0
;Player 2 Score:  3.0

; It never beats its opponent, same as EYE-FOR-EYE.

(display "-----End of Problem 4-----")
(newline)

;"c"
;"c"
;"c"
;"c"
;"c"
;"c"
;"d"
;"c"
;"d"
;"c"
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;::;;:::;;:;:::;;;
;;; Problem 5    		      	
    		      	
; Write a procedure make-eye-for-n-eyes.

; If there are less items than the number n it prints "c". Otherwise it looks for the last n item in
; the other-history. To do this after each item it takes the cdr of the history repeatedly.
; If all of them are "d" then it prints "d", otherwise it prints "c".
    		      	
(define (make-eye-for-n-eyes n)
  ; You need to return a two-argument (my-history other-history) procedure.
  (lambda (my-history other-history)
    (if (= n 0)
        "d"
        (cond ((< (length other-history) n) "c")
              ((equal? (most-recent-play other-history) "c") "c")
              ((equal? (most-recent-play other-history) "d") (if (> n 0)
                                                                 (and (set! other-history (rest-of-plays other-history)) ((make-eye-for-n-eyes (- n 1)) my-history other-history))
                                                                 "d"))))))
                  
                                                                        		      	
; Test cases for make-eye-for-n-eyes: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 5--------")
(newline)    		      	
    		      	
(define one-eye (make-eye-for-n-eyes 1)) ; equivalent to EYE-FOR-EYE
(define two-eye (make-eye-for-n-eyes 2)) ; equivalent to EYE-FOR-TWO-EYE
    		      	
; Similar to one-eye and two-eye.
; Defects only if three recent plays in the history1 is "d"
; Cooperates if any of the three recent plays in hsitory1 is "c"
(define three-eye (make-eye-for-n-eyes 3))
    		      	
; Strategy depends only to the other-history, so dont case my-history
(display "Testing (make-eye-for-n-eyes 1)")
(newline)    		      	
(one-eye the-empty-history (list "d")) ; ANSWER => "d"
(one-eye the-empty-history (list "d" "c" "c")) ; ANSWER => "d"
    		      	
(display "Testing (make-eye-for-n-eyes 2)")
(newline)    		      	
(two-eye the-empty-history (list "d" "c")) ; ANSWER => "c"
(two-eye the-empty-history (list "d" "d" "c")) ; ANSWER => "d"
    		      	
(display "Testing (make-eye-for-n-eyes 3)")
(newline)    		      	
(three-eye the-empty-history (list "d" "d" "d")) ; ANSWER => "d"
(three-eye the-empty-history (list "d" "d" "c")) ; ANSWER => "c"

(display "--------Additional Test Cases for Problem 5--------")

(play-loop one-eye NASTY)
;Player 1 Score:  0.9906542056074766
;Player 2 Score:  1.0373831775700935
;; one-eye is same as EYE-FOR-EYE, so I will not test it further.
;
(play-loop two-eye NASTY)
;Player 1 Score:  0.9789473684210527
;Player 2 Score:  1.0842105263157895
;; two-eye is same as EYE-FOR-TWO-EYES, so I will not test it further.
;
(play-loop three-eye NASTY)
;Player 1 Score:  0.9705882352941176
;Player 2 Score:  1.1176470588235294
;
(play-loop three-eye PATSY)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop three-eye SPASTIC)
;Player 1 Score:  1.6666666666666667
;Player 2 Score:  3.619047619047619
;
(play-loop three-eye EGALITARIAN)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop three-eye EYE-FOR-EYE)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop three-eye (make-eye-for-n-eyes 4))
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop (make-eye-for-n-eyes 4) NASTY)
;Player 1 Score:  0.956989247311828
;Player 2 Score:  1.1720430107526882

; Again, it never beats its oppenent, similar to EYE-FOR-EYE and EYE-FOR-TWO-EYES.
    		      	
(display "-----End of Problem 5-----")
(newline)    		      	

;Testing (make-eye-for-n-eyes 1)
;"d"
;"d"
;Testing (make-eye-for-n-eyes 2)
;"c"
;"d"
;Testing (make-eye-for-n-eyes 3)
;"d"
;"c"

;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;::;;:::;;:;:::;;:
;;; Problem 6    		      	
    		      	
; Write a procedure make-rotating-strategy

; It assign two numbers which are equal to freq0 and freq1 respectively. For each time when freq0 is
; bigger than 0 it decreases freq0 and calls strat0. After freq0 reaches 0, it starts to do the same thin
; for freq1 and strat1. When both of freqs become 0, it sets their original values to them and
; repeat the same things.

(define (make-rotating-strategy strat0 strat1 freq0 freq1)
  (let ((n0 freq0) (n1 freq1))
    (define (a my-history other-history)
      (if (> freq0 0)
          (and (set! freq0 (- freq0 1)) (strat0 my-history other-history))
          (if (> freq1 0)
              (and (set! freq1 (- freq1 1)) (strat1 my-history other-history))
              (and (set! freq0 n0) (set! freq1 n1) (a my-history other-history)))))
    a))
    
           		      	    		      	
; Test cases for make-rotating-strategy: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 6--------")
(newline)    		      	
    		      	
(define rotating-1 (make-rotating-strategy NASTY PATSY 1 1))
; 1 times NASTY 1 times PATSY    		      	
(define (testing rt)    		      	
  (if (eq? rt #f) empty    		      	
      (rt the-empty-history the-empty-history)
      )    		      	
  )    		      	
    		      	
(display "Testing (make-rotating-strategy NASTY PATSY 1 1)")
(newline)    		      	
(testing rotating-1) ; ANSWER => "d"
(testing rotating-1) ; ANSWER => "c"
(testing rotating-1) ; ANSWER => "d"
(testing rotating-1) ; ANSWER => "c"
    		      	
(define rotating-2 (make-rotating-strategy NASTY PATSY 2 2))
; 2 times NASTY 2 times PATSY    		      	
(display "Testing (make-rotating-strategy NASTY PATSY 2 2)")
(newline)    		      	
(testing rotating-2) ; ANSWER => "d"
(testing rotating-2) ; ANSWER => "d"
(testing rotating-2) ; ANSWER => "c"
(testing rotating-2) ; ANSWER => "c"
(testing rotating-2) ; ANSWER => "d"
(testing rotating-2) ; ANSWER => "d"
(testing rotating-2) ; ANSWER => "c"
(testing rotating-2) ; ANSWER => "c"

(display "--------Additional Test Cases for Problem 6--------")

(play-loop rotating-2 NASTY)
;Player 1 Score:  0.5048543689320388
;Player 2 Score:  2.9805825242718447

(play-loop rotating-2 PATSY)
;Player 1 Score:  4.0
;Player 2 Score:  1.5

(play-loop rotating-2 SPASTIC)
;Player 1 Score:  2.4705882352941178
;Player 2 Score:  2.176470588235294

(play-loop rotating-2 EGALITARIAN)
;Player 1 Score:  3.2346938775510203
;Player 2 Score:  2.010204081632653
;
(play-loop rotating-2 EYE-FOR-EYE)
;Player 1 Score:  2.2577319587628866
;Player 2 Score:  2.2577319587628866

(play-loop rotating-2 (make-eye-for-n-eyes 5))
;Player 1 Score:  4.010989010989011
;Player 2 Score:  1.4835164835164836
;
(play-loop rotating-2 rotating-1)
;Player 1 Score:  2.227722772277228
;Player 2 Score:  2.277227722772277
;
; rotating-2 did quite well except against NASTY.
;
(play-loop NASTY (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  1.0388349514563107
;Player 2 Score:  0.9902912621359223
;
(play-loop PATSY (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop SPASTIC (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  3.7676767676767677
;Player 2 Score:  1.7474747474747474
;
(play-loop EGALITARIAN (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop EYE-FOR-EYE (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15) (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15) (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop (make-rotating-strategy (make-eye-for-n-eyes 3) (make-eye-for-n-eyes 5) 15 15) (make-rotating-strategy EGALITARIAN NASTY 15 15))
;Player 1 Score:  1.9636363636363636
;Player 2 Score:  2.7363636363636363

; (make-rotating-strategy EGALITARIAN (make-eye-for-n-eyes 5) 15 15) didn't do quite well, it didn't manage to beat any opponent.
; But I think it is because of EGALITARIAN and "make eye" procedure.
(play-loop EYE-FOR-EYE (make-rotating-strategy NASTY (make-eye-for-n-eyes 5) 15 15))
;Player 1 Score:  0.9904761904761905
;Player 2 Score:  1.0380952380952382
; It managed to beat its opponent when i "rotate" NASTY and "make eye".


(display "-----End of Problem 6-----")
(newline)

;Testing (make-rotating-strategy NASTY PATSY 1 1)
;"d"
;"c"
;"d"
;"c"
;Testing (make-rotating-strategy NASTY PATSY 2 2)
;"d"
;"d"
;"c"
;"c"
;"d"
;"d"
;"c"
;"c"
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:::;::;;;;;::;;;;
;;; Problem 7    		      	
; Write a new strategy, make-higher-order-spastic, which takes a list of strategies as input.

; It adds a free item, which will be deleted in the progress, to the strategies list. It assigns
; this list to a new original-list. At each step it takes the cdr of the strategies and then calls
; its first strategy using car repatedly. When the length of the list becomes 1, it assigns the
; original-list to strategies list and then repeats all.

(define (make-higher-order-spastic strategies)
  (let ((original-list (append (list 'a) strategies)))
    (set! strategies original-list)
    (define (a my-history other-history)
      (if (> (length strategies) 1)
          (and (set! strategies (cdr strategies)) ((car strategies) my-history other-history))
          (and (set! strategies original-list) (a my-history other-history))))
    a))
  
   	
; Test cases for make-higher-order-spastic: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 7--------")
(newline)    		      	
    		      	
(define NASTY-PATSY (make-higher-order-spastic (list NASTY PATSY)))
    		      	
(display "Testing NASTY-PASTY")
(newline)    		      	
(testing NASTY-PATSY) ; ANSWER =>  "d"
(testing NASTY-PATSY) ; ANSWER => "c"
(testing NASTY-PATSY) ; ANSWER => "d"
(testing NASTY-PATSY) ; ANSWER => "c"

(display "--------Additional Test Cases for Problem 7--------")

(play-loop NASTY-PATSY NASTY)
;Player 1 Score:  0.5
;Player 2 Score:  3.0
;
(play-loop NASTY-PATSY PATSY)
;Player 1 Score:  4.0
;Player 2 Score:  1.5
;
(play-loop NASTY-PATSY EGALITARIAN)
;Player 1 Score:  2.5
;Player 2 Score:  2.5
;
(play-loop NASTY-PATSY SPASTIC)
;Player 1 Score:  2.51
;Player 2 Score:  2.21
;
(play-loop NASTY-PATSY EYE-FOR-EYE)
;Player 1 Score:  2.5
;Player 2 Score:  2.5
;
(play-loop NASTY-PATSY (make-eye-for-n-eyes 5))
;Player 1 Score:  4.0
;Player 2 Score:  1.5
;
(play-loop NASTY-PATSY rotating-2)
;Player 1 Score:  2.25
;Player 2 Score:  2.25
;
(play-loop NASTY-PATSY NASTY-PATSY)
;Player 1 Score:  5.0
;Player 2 Score:  0
;
; NASTY-PATSY did quite well, except NASTY.
(play-loop (make-higher-order-spastic (list NASTY PATSY SPASTIC EGALITARIAN EYE-FOR-EYE)) PATSY)
;Player 1 Score:  3.56
;Player 2 Score:  2.16
(define afksf (make-higher-order-spastic (list NASTY PATSY PATSY PATSY)))
(testing afksf)
(testing afksf)
(testing afksf)
(testing afksf)
(testing afksf)
(testing afksf)
;"d"
;"c"
;"c"
;"c"
;"d"
;"c"

(display "-----End of Problem 7-----")
(newline)

;Testing NASTY-PASTY
;"d"
;"c"
;"d"
;"c"
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:::;::;;;;;::;;;:
;;; Problem 8    		      	
; Write a procedure gentle, which takes as input
; a strategy (say strat) and a number
; between 0 and 1 (call it gentleness-factor).
    		      	
; HINT : You can use (bigfloat->flonum (bfrandom))
; to generate random numbers between 0 and 1

; If "c" then it returns "c". Otherwise, it randomly generates a number between 0 and 1. If it is less
; than gentleness factor it prints "d", otherwise it prints "c".
    		      	
(define (gentle strat gentleness-factor)
  (lambda (my-history other-history)
    (let ((original-return (strat my-history other-history)))
      (cond ((equal? original-return "c") "c")
            ((equal? original-return "d") (let ((rand (bigfloat->flonum (bfrandom))))
                                            (if (> rand gentleness-factor)
                                                "d"
                                                "c")))))))


; Test cases for gentle: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 8--------")
(newline)    		      	
    		      	
(display "Testing (gentle NASTY 0.0)")
(newline)    		      	
(testing (gentle NASTY 0.0)) ; ANSWER =>  "d"
(testing (gentle NASTY 0.0)) ; ANSWER =>  "d"
    		      	
(display "Testing (gentle NASTY 1.0)")
(newline)    		      	
(testing (gentle NASTY 1.0)) ; ANSWER =>  "c"
(testing (gentle NASTY 1.0)) ; ANSWER => "c"
    		      	
(define SLIGHTLY-GENTLE-NASTY (gentle NASTY 0.1))
(define SLIGHTLY-GENTLE-EYE-FOR-EYE (gentle EYE-FOR-EYE 0.1))

(display "--------Additional Test Cases for Problem 8--------")

(play-loop SLIGHTLY-GENTLE-NASTY NASTY)
;Player 1 Score:  0.9259259259259259
;Player 2 Score:  1.2962962962962963
;
(play-loop SLIGHTLY-GENTLE-NASTY PATSY)
;Player 1 Score:  4.847619047619047
;Player 2 Score:  0.22857142857142856
;
(play-loop SLIGHTLY-GENTLE-NASTY EGALITARIAN)
;Player 1 Score:  1.055045871559633
;Player 2 Score:  1.2844036697247707
;
(play-loop SLIGHTLY-GENTLE-NASTY SPASTIC)
;Player 1 Score:  2.893617021276596
;Player 2 Score:  0.8191489361702128
;
(play-loop SLIGHTLY-GENTLE-NASTY EYE-FOR-EYE)
;Player 1 Score:  1.351063829787234
;Player 2 Score:  1.297872340425532
;
(play-loop SLIGHTLY-GENTLE-NASTY (make-higher-order-spastic (list NASTY PATSY SPASTIC EGALITARIAN EYE-FOR-EYE)))
;Player 1 Score:  2.0510204081632653
;Player 2 Score:  1.1326530612244898
;
; SLIGHTLY-GENTLE-NASTY -> Mixed results
;
(play-loop SLIGHTLY-GENTLE-EYE-FOR-EYE NASTY)
;Player 1 Score:  0.9223300970873787
;Player 2 Score:  1.3106796116504855
;
(play-loop SLIGHTLY-GENTLE-EYE-FOR-EYE PATSY)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop SLIGHTLY-GENTLE-EYE-FOR-EYE EGALITARIAN)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop SLIGHTLY-GENTLE-EYE-FOR-EYE SPASTIC)
;Player 1 Score:  2.082474226804124
;Player 2 Score:  2.649484536082474
;
(play-loop SLIGHTLY-GENTLE-EYE-FOR-EYE EYE-FOR-EYE)
;Player 1 Score:  3.0
;Player 2 Score:  3.0
;
(play-loop SLIGHTLY-GENTLE-EYE-FOR-EYE (make-higher-order-spastic (list NASTY PATSY SPASTIC EGALITARIAN EYE-FOR-EYE)))
;Player 1 Score:  2.5157894736842104
;Player 2 Score:  2.6736842105263157
;
; SLIGHTLY-GENTLE-EYE-FOR-EYE -> It never beats its opponent (in my test cases)

(display "-----End of Problem 8-----")
(newline)    		      	

;Testing (gentle NASTY 0.0)
;"d"
;"d"
;Testing (gentle NASTY 1.0)
;"c"
;"c"
    		      	
;;; DO NOT CHANGE FOLLOWING LINES, THEY ARE NECESSARY FOR 3 PLAYER GAME.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define *game-association-list3*
  (list (list (list "c" "c" "c") (list 4 4 4))
        (list (list "c" "c" "d") (list 2 2 5))
        (list (list "c" "d" "c") (list 2 5 2))
        (list (list "d" "c" "c") (list 5 2 2))
        (list (list "c" "d" "d") (list 0 3 3))
        (list (list "d" "c" "d") (list 3 0 3))
        (list (list "d" "d" "c") (list 3 3 0))
        (list (list "d" "d" "d") (list 1 1 1))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:::;::;;;;;::;;:;
;;; Problem 9    		      	
;Revise the Scheme code for the two-player game to make a three-player iterated game.


; In Problem 9, I simply copied the code from above, just added methods for 3rd player.
    		      	
(define (play-loop3 strat0 strat1 strat2)
  (define (play-loop-iter count history0 history1 history2 limit)
    (cond ((= count limit) (print-out-results3 history0 history1 history2 limit))
          (else (let ((result0 (strat0 history0 history1 history2))
                      (result1 (strat1 history1 history0 history2))
                      (result2 (strat2 history2 history0 history1)))
                  (play-loop-iter (+ count 1)
                                  (extend-history result0 history0)
                                  (extend-history result1 history1)
                                  (extend-history result2 history2)
                                  limit)))))
  (play-loop-iter 0 the-empty-history the-empty-history the-empty-history (+ 90 (random 21))))
    		      	
; Define "print-out-results" for handling three strategies:
(define (print-out-results3 history0 history1 history2 number-of-games)
  (let ((scores (get-scores3 history0 history1 history2)))
    (newline)
    (display "Player 1 Score: ")
    (display (* 1.0 (/ (car scores) number-of-games)))
    (newline)
    (display "Player 2 Score: ")
    (display (* 1.0 (/ (cadr scores) number-of-games)))
    (newline)
    (display "Player 3 Score: ")
    (display (* 1.0 (/ (caddr scores) number-of-games)))
    (newline)))    		      	
    		      	
; Define "get-scores" for handling three strategies:
(define (get-scores3 history0 history1 history2)
  (define (get-scores3-helper history0 history1 history2 score0 score1 score2)
    (cond ((empty-history? history0)
           (list score0 score1 score2))
          (else (let ((game (make-play (most-recent-play history0)
                                       (most-recent-play history1)
                                       (most-recent-play history2))))
                  (get-scores3-helper 
                   (rest-of-plays history0)
                   (rest-of-plays history1)
                   (rest-of-plays history2)
                   (+ (get-player-points3 0 game) score0)
                   (+ (get-player-points3 1 game) score1)
                   (+ (get-player-points3 2 game) score2))))))
  (get-scores3-helper history0 history1 history2 0 0 0))

; Since our game-association-list's or play-loop's or print-out's names are changed for this problem
; I created get-player-points and get-point-list methods also for 3 player.

(define (get-player-points3 num game)
  (list-ref (get-point-list3 game) num))
(define (get-point-list3 game)    		      	
  (cadr (extract-entry3 game *game-association-list3*)))
    		      	
; Define "extract-entry" for handling three strategies:

(define (extract-entry3 play *list*)
  (cond ((equal? play (car (list-ref *list* 0))) (list-ref *list* 0))
        ((equal? play (car (list-ref *list* 1))) (list-ref *list* 1))
        ((equal? play (car (list-ref *list* 2))) (list-ref *list* 2))
        ((equal? play (car (list-ref *list* 3))) (list-ref *list* 3))
        ((equal? play (car (list-ref *list* 4))) (list-ref *list* 4))
        ((equal? play (car (list-ref *list* 5))) (list-ref *list* 5))
        ((equal? play (car (list-ref *list* 6))) (list-ref *list* 6))
        ((equal? play (car (list-ref *list* 7))) (list-ref *list* 7))
        (else '())))
  

; Test cases for extract-entry3: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 9--------")
(newline)    		      	
(display "Testing extract-entry-3:")
(newline)    		      	
(extract-entry3 (make-play "c" "c" "c") *game-association-list3*)
; ANSWER =>  (("c" "c" "c") (4 4 4))
(extract-entry3 (make-play "c" "c" "d") *game-association-list3*)
; ANSWER => (("c" "c" "d") (2 2 5))
(extract-entry3 (make-play "c" "d" "c") *game-association-list3*)
; ANSWER =>  (("c" "d" "c") (2 5 2))
(extract-entry3 (make-play "c" "d" "d") *game-association-list3*)
; ANSWER =>  (("c" "d" "d") (0 3 3))
(extract-entry3 (make-play "d" "c" "c") *game-association-list3*)
; ANSWER =>  (("d" "c" "c") (5 2 2))
(extract-entry3 (make-play "d" "c" "d") *game-association-list3*)
; ANSWER => (("d" "c" "d") (3 0 3))
(extract-entry3 (make-play "d" "d" "c") *game-association-list3*)
; ANSWER =>  (("d" "d" "c") (3 3 0))
(extract-entry3 (make-play "d" "d" "d") *game-association-list3*)
; ANSWER => (("d" "d" "d") (1 1 1))
(extract-entry3 (make-play "x" "x" "x") *game-association-list3*)
; ANSWER =>  ()    		      	
    		      	
(display "-----End of Problem 9-----")
(newline)

;'(("c" "c" "c") (4 4 4))
;'(("c" "c" "d") (2 2 5))
;'(("c" "d" "c") (2 5 2))
;'(("c" "d" "d") (0 3 3))
;'(("d" "c" "c") (5 2 2))
;'(("d" "c" "d") (3 0 3))
;'(("d" "d" "c") (3 3 0))
;'(("d" "d" "d") (1 1 1))
;'()
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:::;::;;;;;::;;::
;;; Problem 10    		      	
; Write strategies Patsy-3, Nasty-3, and spastic-3 that will work in a three-player game.
; Hint: They are same as NASTY, PATSY, and SPASTIC.

; They are same.

(define (PATSY-3 my-history other-history-1 other-history-2)
  "c")    		      	
    		      	
(define (NASTY-3 my-history other-history-1 other-history-2)
  "d")   		      	
    		      	
(define (SPASTIC-3 my-history other-history-1 other-history-2)
  (if (= (random 2) 0)
      "c"
      "d"))   		      	

; If history is empty, "c", otherwise if both of them is "d" prints "d" -> SOFT
; If history is empty, "c", otherwise if one of them is "d" prints "d" -> TOUGH

(define (TOUGH-EYE-FOR-EYE my-history other-history-1 other-history-2)
  (if (empty-history? my-history)
      "c"
      (let ((a1 (most-recent-play other-history-1)) (a2 (most-recent-play other-history-2)))
        (if (or (equal? a1 "d") (equal? a2 "d"))
            "d"
            "c"))))


(define (SOFT-EYE-FOR-EYE my-history other-history-1 other-history-2)
  (if (empty-history? my-history)
      "c"
      (let ((a1 (most-recent-play other-history-1)) (a2 (most-recent-play other-history-2)))
        (if (and (equal? a1 "d") (equal? a2 "d"))
            "d"
            "c"))))

; Test cases for strategies: (When you write your procedure you can
; test it with the below test cases. Initially it returns #f since
; your-answer-here is defined as #f. But when you complete the procedure
; It should return the correct answers below.)
(display "--------Problem 10--------")
(newline)    		      	
    		      	
(display "Testing NASTY-3:")    		      	
(newline)    		      	
(NASTY-3 (list "c") (list "c") (list "c")) ; ANSWER => "d"
(NASTY-3 (list "c") (list "d") (list "c")) ; ANSWER => "d"
(NASTY-3 (list "d") (list "d") (list "d")) ; ANSWER => "d"
    		      	
(display "Testing PATSY-3:")    		      	
(newline)    		      	
(PATSY-3 (list "c") (list "c") (list "c")) ; ANSWER => "c"
(PATSY-3 (list "d") (list "c") (list "c")) ; ANSWER => "c"
(PATSY-3 (list "d") (list "d") (list "d")) ; ANSWER => "c"
    		      	
(display "Testing SPASTIC-3:")    		      	
(newline)    		      	
(SPASTIC-3 (list "c") (list "c") (list "c")) ; ANSWER => 50% of time "d", 50% of time "c"
    		      	
    		      	
(display "Testing TOUGH-EYE-FOR-EYE:")
(newline)    		      	
(TOUGH-EYE-FOR-EYE (list "d") (list "c") (list "c")) ; ANSWER => "c"
(TOUGH-EYE-FOR-EYE (list "c") (list "c") (list "d")) ; ANSWER => "d"
(TOUGH-EYE-FOR-EYE (list "c") (list "d") (list "c")) ; ANSWER => "d"
(TOUGH-EYE-FOR-EYE (list "c") (list "d") (list "d")) ; ANSWER => "d"
    		      	
(display "Testing SOFT-EYE-FOR-EYE:")
(newline)    		      	
(SOFT-EYE-FOR-EYE (list "c") (list "c") (list "d")) ; ANSWER => "c"
(SOFT-EYE-FOR-EYE (list "c") (list "d") (list "c")) ; ANSWER => "c"
(SOFT-EYE-FOR-EYE (list "c") (list "d") (list "d")) ; ANSWER => "d"
(SOFT-EYE-FOR-EYE (list "d") (list "c") (list "c")) ; ANSWER => "c"

(display "--------Additional Test Cases for Problem 10--------")

(play-loop3 NASTY-3 PATSY-3 SPASTIC-3)
;Player 1 Score: 4.089108910891089
;Player 2 Score: 1.0891089108910892
;Player 3 Score: 2.4554455445544554
;
(play-loop3 TOUGH-EYE-FOR-EYE NASTY-3 PATSY-3)
;Player 1 Score: 2.9901960784313726
;Player 2 Score: 3.019607843137255
;Player 3 Score: 0.0196078431372549
;
(play-loop3 TOUGH-EYE-FOR-EYE NASTY-3 SPASTIC-3)
;Player 1 Score: 2.0277777777777777
;Player 2 Score: 2.0555555555555554
;Player 3 Score: 0.5
;
(play-loop3 TOUGH-EYE-FOR-EYE SPASTIC-3 PATSY-3)
;Player 1 Score: 3.5779816513761467
;Player 2 Score: 3.5779816513761467
;Player 3 Score: 2.311926605504587
;
(play-loop3 SOFT-EYE-FOR-EYE NASTY-3 PATSY-3)
;Player 1 Score: 2.0
;Player 2 Score: 5.0
;Player 3 Score: 2.0
;
(play-loop3 SOFT-EYE-FOR-EYE NASTY-3 SPASTIC-3)
;Player 1 Score: 1.4516129032258065
;Player 2 Score: 2.870967741935484
;Player 3 Score: 1.4838709677419355
;
(play-loop3 SOFT-EYE-FOR-EYE SPASTIC-3 PATSY-3)
;Player 1 Score: 3.0392156862745097
;Player 2 Score: 4.480392156862745
;Player 3 Score: 3.0392156862745097
;
(play-loop3 SOFT-EYE-FOR-EYE TOUGH-EYE-FOR-EYE NASTY-3)
;Player 1 Score: 1.0
;Player 2 Score: 1.0309278350515463
;Player 3 Score: 1.0618556701030928
;
(play-loop3 SOFT-EYE-FOR-EYE TOUGH-EYE-FOR-EYE PATSY-3)
;Player 1 Score: 4.0
;Player 2 Score: 4.0
;Player 3 Score: 4.0
;
(play-loop3 SOFT-EYE-FOR-EYE TOUGH-EYE-FOR-EYE SPASTIC-3)
;Player 1 Score: 1.8453608247422681
;Player 2 Score: 2.9587628865979383
;Player 3 Score: 2.3402061855670104
;
; TOUGH-EYE-FOR-EYE did quite well on all cases. But SOFT-EYE-FOR-EYE wasn't that good.
  		      	    		      	
(display "-----End of Problem 10-----")
(newline)    		      	

;Testing NASTY-3:
;"d"
;"d"
;"d"
;Testing PATSY-3:
;"c"
;"c"
;"c"
;Testing SPASTIC-3:
;"c"
;Testing TOUGH-EYE-FOR-EYE:
;"c"
;"d"
;"d"
;"d"
;Testing SOFT-EYE-FOR-EYE:
;"c"
;"c"
;"d"
;"c"
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;:::;::;;;;;::;:;;
; END OF PROJECT    		      	
    		      	
    		      	
