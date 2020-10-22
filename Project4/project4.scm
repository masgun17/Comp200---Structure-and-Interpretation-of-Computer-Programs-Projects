;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;;;::;:;;
;;;   The Object-Oriented Adventure Game
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;;;::;:;:
;;;    		      	
;;; masgun17@ku.edu.tr     Sat Dec  1 00:58:29 2018
;;;    		      	
;;; Before you start:    		      	
;;; * Please read the project handout available on the course
;;;   web site first to get a basic idea about the project and the
;;;   logic behind it, then to find out the details about what
;;;   your tasks are for the rest of the project.
;;;    		      	
;;; * The following code should be studied and loaded for this
;;;   project.  Please do not modify these files, put all your work in
;;;   this file.    		      	
;;;    		      	
;;; - objsys.scm: support for an elementary object system
;;; - objtypes.scm: a few nice object classes
;;; - setup.scm: a bizarre world constructed using these classes
;;;    		      	
;;; * Plan your work with pencil and paper before starting to code.
;;;    		      	
;;; While you are working:    		      	
;;; * Type all your work and notes in the appropriate sections of this file.
;;; * Please do not delete any of the existing lines.
;;; * Use the procedure names given in the instructions.
;;; * Remember to frequently save your file.
;;; * Use semicolon (;) to comment out text, tests and unused code.
;;; * Remember to document your code (in this file)
;;; * Remember our collaboration policy: you can discuss with your friends but:
;;;    		      	
;;;   *** NOTHING WRITTEN GETS EXCHANGED ***
;;;    		      	
;;;    		      	
;;; When you are done:    		      	
;;; * Perform a final save and submit your work following the instructions.
;;; * Please do not make any modifications after midnight on the due date.
;;; * Please send an email comp200-common@ku.edu.tr if you have any questions.
;;; * Make sure your file loads without errors:
;;; ****************************************************************************
;;; ***  Your code should run without any syntactic errors. Projects  causing error will NOT be graded. ***
;;; ****************************************************************************
;;;    		      	
;; Do NOT modify or delete the lines below.
(#%require (only racket/base random))
(load "objsys.scm")    		      	
(load "objtypes.scm")    		      	
(load "setup.scm")    		      	
(define nil '())    		      	
(define your-answer-here #f)    		      	
;;;;;;;;;    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;;;::;::;
;;; PART II. Programming Assignment
;;;    		      	
;;; The answers to the computer exercises in Section 5 go in the
;;; appropriate sections below.
;;;    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;;;::;:::
;;;;;;;;;;;;; Setting up ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    		      	
;;;;;;;;;;;;; CODES: ;;;;;;;;;;;;;
;;    		      	

;(setup 'Mertcan)

;(ask me 'look-around)
;(ask me 'name)
;(ask me 'say (list "Hello World"))
;(ask me 'go 'down)
;(ask me 'go 'west)
;(ask me 'take (thing-named 'engineering-book))
;(ask me 'toss 'engineering-book)
;(ask me 'die)

;; At this part first I get the location by (ask me 'look-around). Then depending on the location
;; I moved the avatar two times by (ask me 'go 'down) and (ask me 'go 'west) to reach a place
;; where a mobile thing is located. In my run it was the engineering-book, so i picked it by
;; (ask me 'take (thing-named 'engineering-book)). Then I dropped it by
;; (ask me 'toss 'engineering-book). And then I killed the avatar by (ask me 'die).
;; And I commented out 2 lines, because everytime I run the code, avatar spawns in a different
;; room so it does not have access to specific item "engineering-book" and so it gives an error.

    		      	
;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;;;:::;;;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    		      	
    		      	
;> (ask me 'look-around)
;
;You are in graduation-stage 
;You are not holding anything. 
;There is no stuff in the room. 
;There are no other people around you. 
;The exits are in directions: down ok
;> (ask me 'name)
;mertcan
;> (ask me 'say (list "Hello World"))
;
;At graduation-stage mertcan says -- Hello World 
;> (ask me 'go 'down)
;
;mertcan moves from graduation-stage to great-court 
;lambda-man moves from parking-lot to eng-building 
;lambda-man moves from eng-building to sci-building 
;lambda-man moves from sci-building to sos-building 
;comp200-student moves from bookstore to suzy-cafe 
;At suzy-cafe comp200-student says -- Hi suzy 
;At suzy-cafe comp200-student says -- I take coke from suzy-cafe 
;prof-yuret moves from migros to cici-bufe 
;At cici-bufe prof-yuret says -- Hi cici 
;alyssa-p-hacker moves from soccer-field to eng-building 
;alyssa-p-hacker moves from eng-building to eng-z21 
;ben-bitdiddle moves from eng-auditorium to eng-z21 
;At eng-z21 ben-bitdiddle says -- Hi alyssa-p-hacker 
;ben-bitdiddle moves from eng-z21 to deans-office 
;At deans-office ben-bitdiddle says -- I take transcript from deans-office 
;--- the-clock Tick 0 --- 
;You are in great-court 
;You are not holding anything. 
;You see stuff in the room: flag-pole 
;There are no other people around you. 
;The exits are in directions: up east west south north #t
;> (ask me 'go 'west)
;
;mertcan moves from great-court to library 
;At cici-bufe cici says -- Prepare to suffer, prof-yuret ! 
;At cici-bufe prof-yuret says -- Ouch! 3 hits is more than I want! 
;At cici-bufe prof-yuret says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;prof-yuret moves from cici-bufe to heaven 
;At suzy-cafe suzy says -- Prepare to suffer, comp200-student ! 
;At suzy-cafe comp200-student says -- Ouch! 2 hits is more than I want! 
;lambda-man moves from sos-building to cas-building 
;lambda-man moves from cas-building to great-court 
;At great-court lambda-man says -- I try but cannot take flag-pole 
;comp200-student moves from suzy-cafe to student-center 
;alyssa-p-hacker moves from eng-z21 to eng-auditorium 
;alyssa-p-hacker moves from eng-auditorium to eng-z21 
;At eng-z21 alyssa-p-hacker says -- I take problem-set from eng-z21 
;ben-bitdiddle moves from deans-office to eng-z21 
;At eng-z21 ben-bitdiddle says -- Hi alyssa-p-hacker 
;--- the-clock Tick 1 --- 
;You are in library 
;You are not holding anything. 
;You see stuff in the room: engineering-book 
;There are no other people around you. 
;The exits are in directions: west east #t
;> (ask me 'take (thing-named 'engineering-book))
;
;At library mertcan says -- I take engineering-book from library 
;> (ask me 'toss 'engineering-book)
;
;At library mertcan says -- I drop engineering-book at library 
;> (ask me 'die)
;
;At library mertcan says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;mertcan moves from library to heaven 
;At heaven mertcan says -- Hi prof-yuret game-over-for-you-dude    		      	
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;;;:::;;:
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;;;;
;;;;;; Understanding installation;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;;;:
;;    		      	
;;;;;;;;;;;;; ANSWER: ;;;;;;;;;;;;;
;;    		      	
    		      	
; Each method can be written as;
; (delegate person-part self 'INSTALL) --> ((person-part 'INSTALL) self)
; (ask person-part 'INSTALL) --> ((person-part 'INSTALL) person-part)
; delegate procedure allow the autonomous person to be installed, however ask procedure
; only allows the person-part to be installed. So when we move an autonomous person, actually
; it stays there on ask procedure.
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;;:;
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;;::
;;;;;;;;;;;; Who just died? ;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;:;;
;;    		      	
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    		      	

; Main method to check the person recently died.
;(if (not (equal? (ask heaven 'things) '()))
;    (ask (car (ask heaven 'things)) 'name)
;    "No one died.")

; Codes I ran for transcript
;(run-clock 1)
;(if (not (equal? (ask heaven 'things) '()))
;    (ask (car (ask heaven 'things)) 'name)
;    "No one died.")
		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;:;:
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    		      	
    		      	
;; When a person dies, it goes to heaven, which is a place object. Place object is a subclass of
;; container class, so it has a list of things inside its. So if we call these things we can reach
;; the name of the person who recently died.
;; To prevent error message on the console, I added an if condition.
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;::;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    		      	
    		      	
;ready
;> (run-clock 1)
;
;cici moves from cici-bufe to suzy-cafe 
;At suzy-cafe cici says -- Hi suzy 
;At suzy-cafe cici says -- Prepare to suffer, suzy ! 
;At suzy-cafe suzy says -- Ouch! 3 hits is more than I want! 
;At suzy-cafe suzy says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;suzy moves from suzy-cafe to heaven 
;lambda-man moves from registrar-office to adm-building 
;lambda-man moves from adm-building to dorms 
;At dorms lambda-man says -- Hi alyssa-p-hacker 
;comp200-student moves from soccer-field to eng-building 
;comp200-student moves from eng-building to soccer-field 
;At soccer-field comp200-student says -- I take football from soccer-field 
;prof-yuret moves from divan to cici-bufe 
;At cici-bufe prof-yuret says -- I take kofte from cici-bufe 
;alyssa-p-hacker moves from dorms to adm-building 
;alyssa-p-hacker moves from adm-building to dorms 
;At dorms alyssa-p-hacker says -- Hi lambda-man 
;ben-bitdiddle moves from sci-building to eng-building 
;--- the-clock Tick 0 --- done
;> (if (not (equal? (ask heaven 'things) '()))
;    (ask (car (ask heaven 'things)) 'name)
;    "No one died.")
;suzy
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;::;:::
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;:::;;;
;;;;;;;; Having a quick look ;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;:;:;:::;;:;:::;;:
;;    		      	
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    		      	
    		      	
;your-answer-here    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;;;;
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    		      	
    		      	
;your-answer-here    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;;;:
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    		      	
    		      	
;your-answer-here    		      	
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;;:;
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;;::
;;;;;; Computer exercise: But I'm too young to die!! ;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;:;;
;;    		      	
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    		      	
    		      	
(define (make-person name birthplace) ; symbol, location -> person
  (let ((mobile-thing-part (make-mobile-thing name birthplace))
        (container-part    (make-container))
        (health            3)    		      	
        (strength          1)    		      	
        (lives             3))    		      	
    (lambda (message)    		      	
      (case message    		      	
        ((PERSON?) (lambda (self) #T))
        ((STRENGTH) (lambda (self) strength))
        ((HEALTH) (lambda (self) health))
        ((SAY)    		      	
         (lambda (self list-of-stuff)
           (ask screen 'TELL-ROOM (ask self 'location)
                (append (list "At" (ask (ask self 'LOCATION) 'NAME)
                              (ask self 'NAME) "says --")
                        list-of-stuff))
           'SAID-AND-HEARD))
        ((HAVE-FIT)    		      	
         (lambda (self)    		      	
           (ask self 'SAY '("Yaaaah! I am upset!"))
           'I-feel-better-now))
    		      	
        ((PEOPLE-AROUND)	; other people in room...
         (lambda (self)    		      	
           (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
                  (people (myfilter (lambda (x) (is-a x 'PERSON?)) in-room)))
             (delq self people))))
    		      	
        ((STUFF-AROUND)		; stuff (non people) in room...
         (lambda (self)    		      	
           (let* ((in-room (ask (ask self 'LOCATION) 'THINGS))
                  (stuff (myfilter (lambda (x) (not (is-a x 'PERSON?))) in-room)))
             stuff)))    		      	
    		      	
        ((PEEK-AROUND)		; other people's stuff...
         (lambda (self)    		      	
           (let ((people (ask self 'PEOPLE-AROUND)))
             (accumulate append '() (map (lambda (p) (ask p 'THINGS)) people)))))
    		      	
        ((TAKE)    		      	
         (lambda (self thing)    		      	
           (cond ((ask self 'HAVE-THING? thing)  ; already have it
                  (ask self 'SAY (list "I am already carrying"
                                       (ask thing 'NAME)))
                  #f)    		      	
                 ((or (is-a thing 'PERSON?)
                      (not (is-a thing 'MOBILE-THING?)))
                  (ask self 'SAY (list "I try but cannot take"
                                       (ask thing 'NAME)))
                  #F)    		      	
                 (else    		      	
                  (let ((owner (ask thing 'LOCATION)))
                    (ask self 'SAY (list "I take" (ask thing 'NAME)
                                         "from" (ask owner 'NAME)))
                    (if (is-a owner 'PERSON?)
                        (ask owner 'LOSE thing self)
                        (ask thing 'CHANGE-LOCATION self))
                    thing)))))    		      	
    		      	
        ((LOSE)    		      	
         (lambda (self thing lose-to)
           (ask self 'SAY (list "I lose" (ask thing 'NAME)))
           (ask self 'HAVE-FIT)
           (ask thing 'CHANGE-LOCATION lose-to)))
    		      	
        ((DROP)    		      	
         (lambda (self thing)    		      	
           (ask self 'SAY (list "I drop" (ask thing 'NAME)
                                "at" (ask (ask self 'LOCATION) 'NAME)))
           (ask thing 'CHANGE-LOCATION (ask self 'LOCATION))))
    		      	
        ((GO-EXIT)    		      	
         (lambda (self exit)    		      	
           (ask exit 'USE self)))
    		      	
        ((GO)    		      	
         (lambda (self direction) ; person, symbol -> boolean
           (let ((exit (ask (ask self 'LOCATION) 'EXIT-TOWARDS direction)))
             (if (is-a exit 'EXIT?)
                 (ask self 'GO-EXIT exit)
                 (begin (ask screen 'TELL-ROOM (ask self 'LOCATION)
                             (list "No exit in" direction "direction"))
                        #F)))))
        ((SUFFER)    		      	
         (lambda (self hits)    		      	
           (ask self 'SAY (list "Ouch!" hits "hits is more than I want!"))
           (set! health (- health hits))
           (if (<= health 0) (ask self 'DIE))
           health))    		      	
    		      	
        ((DEATH-SCREAM)    		      	
         (lambda (self)    		      	
           (ask screen 'TELL-WORLD
                '("An earth-shattering, soul-piercing scream is heard..."))))
    		      	
        ((ENTER-ROOM)    		      	
         (lambda (self)    		      	
           (let ((others (ask self 'PEOPLE-AROUND)))
             (if (not (null? others))
                 (ask self 'SAY (cons "Hi" (names-of others)))))
           (ask (ask self 'location) 'make-noise self)
           #T))    		      	
    		      	
        ;; Here is the original DIE method
        #|    		      	
	 ((DIE)    		      	
	  (lambda (self)    		      	
	    (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
	    (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
	 	     (ask self 'THINGS))
	    (ask self 'DEATH-SCREAM)
	    (ask death-exit 'USE self)
	    'GAME-OVER-FOR-YOU-DUDE))
   |#    		      	
        ;; Your version goes here:
    		      	
        ((DIE)    		      	
         (lambda (self)
           (set! lives (- lives 1))
           (ask self 'SAY '("SHREEEEK!  I, uh, suddenly feel very faint..."))
           (for-each (lambda (item) (ask self 'LOSE item (ask self 'LOCATION)))
                     (ask self 'THINGS))
           (if (not (> lives 0))
               (begin (ask self 'DEATH-SCREAM)
                      (ask death-exit 'USE self)
                      'GAME-OVER-FOR-YOU-DUDE)
               (begin (set! health 3)
                      (ask self 'SAY '(You lost 1 health.))
                      (ask self 'CHANGE-LOCATION birthplace)
                      (ask self 'INSTALL)))))		      	
    		      	
        (else (find-method message mobile-thing-part container-part))))))
    		      	
;(setup 'Mertcan)   		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;:;:
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    		      	
    		      	
;; I added a kind of counter for lives by (set! lives (- lives 1)). Every time the person dies,
;; it still says something and drops items however it doesn't call death-scream and death-exit.
;; When lives become 0(or negative) it also calls these methods too.
    		      	
    		      	    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;::;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    		      	
   		      	
;> (ask me 'die)
;
;At eng-auditorium mertcan says -- SHREEEEK!  I, uh, suddenly feel very faint... "You lost 1 health."
;> (ask me 'die)
;
;At eng-auditorium mertcan says -- SHREEEEK!  I, uh, suddenly feel very faint... "You lost 1 health."
;> (ask me 'die)
;
;At eng-auditorium mertcan says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;An earth-shattering, soul-piercing scream is heard... 
;mertcan moves from eng-auditorium to heaven game-over-for-you-dude		      	
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;::;:::
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;:::;;;
;;; Computer exercise: Perhaps to arm oneself against a sea of .... ;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;;;:::;;:
;;    		      	
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    		      	

(define (make-weapon name location damage)
  (let ((mobile-thing-part (make-mobile-thing name location)))
    (lambda (message)
      (case message
        ((WEAPON?) (lambda (self) #t))
        ((DAMAGE) (lambda (self) damage))
        ((HIT)
         (lambda (weapon me person)
           (cond ((ask me 'HAVE-THING? weapon)
                  (cond ((is-a person 'PERSON?)
                         (and (ask me 'SAY (list "Prepare to suffer now with my mighty weapon,"
                                                 (ask person 'NAME) "!"))
                              (ask me 'SAY (list "I hit" (ask person 'NAME)
                                                 "with" (ask weapon 'NAME)))
                              (ask person 'SUFFER damage))))))))
        (else (get-method message mobile-thing-part))))))

(define (create-weapon name location damage)
  (create make-weapon name location damage))

;(setup 'Mertcan)

;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;;;;
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    		      	
    		      	
;; I created a new class for weapons, which inherits from mobile things. It responds to weapon?,
;; damage and hit. Since it inherits from mobile things, it also responds all messages, which
;; mobile things also respond.
;; Weapon? and damage parts are straightforward, however hit part is a little bit more complicated.
;; It first checks whether it has the given weapon name, then checks the thing it will attack to
;; decide it is whether person or not. Then it hits the person and person suffer damage equal
;; to weapon's damage stat.
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;;;:
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    		      	

;> (ask screen 'deity-mode #f)
;> (ask me 'look-around)
;
;You are in eng-b30 
;You are not holding anything. 
;You see stuff in the room: lecture-notes white-board 
;You see other people: alyssa-p-hacker 
;The exits are in directions: up ok
;> (ask me 'go 'up)
;
;mertcan moves from eng-b30 to eng-z21 
;At eng-z21 alyssa-p-hacker says -- Hi mertcan 
;alyssa-p-hacker moves from eng-z21 to deans-office 
;--- the-clock Tick 0 --- 
;You are in eng-z21 
;You are not holding anything. 
;You see stuff in the room: comp200-midterm student-riot problem-set 
;There are no other people around you. 
;The exits are in directions: up down south out #t
;> (ask me 'take (thing-named 'student-riot))
;
;At eng-z21 mertcan says -- I take student-riot from eng-z21 
;> (ask me 'go  'down)
;
;mertcan moves from eng-z21 to eng-b30 
;At eng-b30 alyssa-p-hacker says -- Hi mertcan 
;At eng-b30 alyssa-p-hacker says -- I try but cannot take white-board 
;--- the-clock Tick 1 --- 
;You are in eng-b30 
;You are holding: student-riot 
;You see stuff in the room: lecture-notes white-board 
;You see other people: alyssa-p-hacker 
;The exits are in directions: up #t
;> (ask (thing-named 'student-riot) 'hit me (thing-named 'alyssa-p-hacker))
;
;At eng-b30 mertcan says -- Prepare to suffer now with my mighty weapon, alyssa-p-hacker ! 
;At eng-b30 mertcan says -- I hit alyssa-p-hacker with student-riot 
;At eng-b30 alyssa-p-hacker says -- Ouch! 4 hits is more than I want! 
;At eng-b30 alyssa-p-hacker says -- SHREEEEK!  I, uh, suddenly feel very faint... -1
    		      	
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;;:;
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;;::
;;;;;;;; Computer exercise: Good thing I'm armed and dangerous ;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;:;;
;;    		      	
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    		      	

(define (make-violent-person name birthplace activity miserly violent)
  (let ((autonomous-player-part (make-autonomous-player name birthplace activity miserly)))
    (lambda (message)
      (case message
        ((VIOLENT?) (lambda (self) #T))
        ((INSTALL) (lambda (self)
                     (ask clock 'ADD-CALLBACK
                          (make-clock-callback 'act-violently self 'ACT-VIOLENTLY))
                     (delegate autonomous-player-part self 'INSTALL)))
        ((ACT-VIOLENTLY)
         (lambda (self)
           (let ((person (pick-random (ask self 'PEOPLE-AROUND)))
                 (weapon (pick-random (myfilter (lambda (x) (is-a x 'WEAPON?))(ask self 'THINGS)))))
             (if (and (= 0 (random violent)) person weapon)
                 (ask weapon 'HIT self person)))))
        ((DIE)
         (lambda (self)
           (ask clock 'REMOVE-CALLBACK self 'act-violently)
           (delegate autonomous-player-part self 'DIE)))
        (else (get-method message autonomous-player-part))))))

(define (create-violent-person name birthplace activity miserly violent)
  (create make-violent-person name birthplace activity miserly violent))
                         
                        
;(setup 'Mertcan)                         
             
           
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;:;:
;;;;;;;;;;;;; EXPLANATION: ;;;;;;;;;;;;;
;;    		      	
    		      	
;; I created a violent-person class which inherits from autonomous-player. It answers to violent? and at each clock
;; tick it calls install. Depending on install, and the violent rate of the person it may act violently, which means
;; it selects a random person in the same location and selects random weapon from its 'inventory' and then hit
;; the person with that weapon. (To apply the violent rate in action, I used random method) It may also die as a person
;; and when it dies, it dies as a normal person and additionally it send remove-callback message to the clock.
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;::;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    		      	

; After adding a violent player viol1 to the setup.scm,

;> (run-clock 1)
;
;viol1 moves from cas-building to sos-building 
;viol1 moves from sos-building to cas-building 
;suzy moves from suzy-cafe to bookstore 
;lambda-man moves from graduation-stage to great-court 
;comp200-student moves from sci-building to sos-building 
;comp200-student moves from sos-building to sci-building 
;prof-yuret moves from eng-auditorium to eng-z21 
;alyssa-p-hacker moves from parking-lot to eng-building 
;At eng-building alyssa-p-hacker says -- Hi ben-bitdiddle 
;ben-bitdiddle moves from eng-building to sci-building 
;At sci-building ben-bitdiddle says -- Hi comp200-student 
;--- the-clock Tick 0 --- done
;> (run-clock 1)
;
;viol1 moves from cas-building to great-court 
;At great-court viol1 says -- Hi lambda-man 
;At great-court viol1 says -- I try but cannot take flag-pole 
;suzy moves from bookstore to suzy-cafe 
;lambda-man moves from great-court to graduation-stage 
;comp200-student moves from sci-building to sos-building 
;At sos-building comp200-student says -- I take stick-of-chalk from sos-building 
;prof-yuret moves from eng-z21 to eng-auditorium 
;At eng-auditorium prof-yuret says -- I take final-exam from eng-auditorium 
;alyssa-p-hacker moves from eng-building to parking-lot 
;alyssa-p-hacker moves from parking-lot to eng-building 
;ben-bitdiddle moves from sci-building to sos-building 
;At sos-building ben-bitdiddle says -- Hi comp200-student 
;ben-bitdiddle moves from sos-building to cas-building 
;--- the-clock Tick 1 --- done
;> (run-clock 1)
;
;viol1 moves from great-court to student-center 
;At student-center viol1 says -- I take inflatable-lambda from student-center 
;lambda-man moves from graduation-stage to great-court 
;lambda-man moves from great-court to library 
;lambda-man moves from library to great-court 
;comp200-student moves from sos-building to cas-building 
;At cas-building comp200-student says -- Hi ben-bitdiddle 
;prof-yuret moves from eng-auditorium to eng-z21 
;alyssa-p-hacker moves from eng-building to soccer-field 
;alyssa-p-hacker moves from soccer-field to eng-building 
;ben-bitdiddle moves from cas-building to great-court 
;At great-court ben-bitdiddle says -- Hi lambda-man 
;--- the-clock Tick 2 --- done
;> (run-clock 1)
;
;viol1 moves from student-center to suzy-cafe 
;At suzy-cafe viol1 says -- Hi suzy 
;At suzy-cafe viol1 says -- I take coke from suzy-cafe 
;At suzy-cafe viol1 says -- Prepare to suffer now with my mighty weapon, suzy ! 
;At suzy-cafe viol1 says -- I hit suzy with inflatable-lambda 
;At suzy-cafe suzy says -- Ouch! 3 hits is more than I want! 
;At suzy-cafe suzy says -- SHREEEEK!  I, uh, suddenly feel very faint... 
;cici moves from cici-bufe to computer-club 
;At computer-club cici says -- Hi mertcan 
;At computer-club cici says -- Prepare to suffer, mertcan ! 
;At computer-club mertcan says -- Ouch! 2 hits is more than I want! 
;At suzy-cafe suzy says -- Prepare to suffer, viol1 ! 
;At suzy-cafe viol1 says -- Ouch! 2 hits is more than I want! 
;lambda-man moves from great-court to student-center 
;lambda-man moves from student-center to great-court 
;At great-court lambda-man says -- Hi ben-bitdiddle 
;lambda-man moves from great-court to cas-building 
;At cas-building lambda-man says -- Hi comp200-student 
;comp200-student moves from cas-building to great-court 
;At great-court comp200-student says -- Hi ben-bitdiddle 
;At great-court comp200-student says -- I take student-riot from great-court 
;prof-yuret moves from eng-z21 to eng-auditorium 
;alyssa-p-hacker moves from eng-building to parking-lot 
;alyssa-p-hacker moves from parking-lot to eng-building 
;ben-bitdiddle moves from great-court to student-center 
;ben-bitdiddle moves from student-center to suzy-cafe 
;At suzy-cafe ben-bitdiddle says -- Hi viol1 suzy 
;At suzy-cafe ben-bitdiddle says -- I take coke from viol1 
;At suzy-cafe viol1 says -- I lose coke 
;At suzy-cafe viol1 says -- Yaaaah! I am upset! 
;--- the-clock Tick 3 --- done
    		      	
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;::;:::
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;:::;;;
;;; Computer exercise: A good hacker could defuse this situation ;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;;:;:::;;:
;;    		      	
;;;;;;;;;;;;; CODE: ;;;;;;;;;;;;;
;;    		      	
(define (make-bomb name location damage)
  (let ((aware-part (make-aware-thing))
        (mobile-part (make-mobile-thing name location))
        (armed? #f))
    (lambda (message)
      (case message
        ((BOMB?) (lambda (self) #T))
        ((ARMED?) (lambda (self) armed?))
        ((ARM)
         (lambda (self)
           (set! armed? #t)
           (if (is-a (ask self 'location) 'AVATAR?)
               (ask self 'CHANGE-LOCATION (ask (ask self 'location) 'location)))
           (ask screen 'TELL-ROOM  (ask self 'LOCATION) `(,name is disarmed at ,(ask (ask self 'location) 'name)))))           
        ((DISARM)
         (lambda (self)
           (set! armed? #f)
           (ask screen 'TELL-ROOM  (ask self 'LOCATION) `(,name is disarmed at ,(ask (ask self 'location) 'name)))))
        ((TRIGGER)   	    	   	
         (lambda (self)
           (if armed? (ask self 'ACTIVATE))
           ))
        ((HEARD-NOISE)   	    	   	
         (lambda (self who)
           (ask self 'TRIGGER)
           ))
        ((ACTIVATE)   	    	   	
         (lambda (self)
           (let ((in-room (ask (ask self 'LOCATION) 'THINGS))
                 (pain (random-number damage)))
             (let ((people (myfilter (lambda (x) (is-a x 'PERSON?)) in-room)))
               (ask self 'EMIT `(,name is activated and dealt ,pain damage to each))
               (for-each (lambda (person) (ask person 'SUFFER pain)) people)
               (ask self 'DESTROY))
             )))
        (else   	    	   	
         (find-method message aware-part mobile-part))))))

(define (create-bomb name location damage)
  (create make-bomb name location damage))

(setup 'Mertcan)
    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;:;;::;;;;
;;;;;;;;;;;;; TRANSCRIPT: ;;;;;;;;;;;;;
;;    		      	
;> (ask me 'look-around)
;
;You are in amphitheater 
;You are not holding anything. 
;You see stuff in the room: steaky sicp-book umbrella 
;There are no other people around you. 
;The exits are in directions: west ok
;> (ask me 'get 'steaky)
;
;At amphitheater mertcan says -- I take steaky from amphitheater 
;> (ask (thing-named 'steaky) 'arm)
;
;steaky is disarmed at amphitheater     		      	
;
;After many clock ticks...
;
;
;> (run-clock 1)
;
;lambda-man moves from sci-building to sos-building 
;lambda-man moves from sos-building to amphitheater 
;At amphitheater lambda-man says -- Hi mertcan 
;At amphitheater steaky is activated and dealt 1 damage to each 
;At amphitheater lambda-man says -- Ouch! 1 hits is more than I want! 
;At amphitheater mertcan says -- Ouch! 1 hits is more than I want! 
;lambda-man moves from amphitheater to sos-building 
;ben-bitdiddle moves from suzy-cafe to student-center 
;At student-center ben-bitdiddle says -- Hi suzy 
;viol1 moves from graduation-stage to great-court 
;viol1 moves from great-court to library 
;cici moves from bookstore to suzy-cafe 
;comp200-student moves from eng-z21 to eng-auditorium 
;--- the-clock Tick 25 --- done    		      			      	
    		      	
    		      	
;;    		      	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;:;;::;;;:
    		      	

    		      	
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;:;;::;;:;
;# DO NOT FORGET TO SUBMIT YOUR WORK BEFORE THE DEADLINE!         #
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;:;;::;;::
;# GOOD LUCK!                                                     #
;;;;;;;::;::;:::;;;;::::;;::::;;::::::;:;:::;:::;;::;;;:;::;:::;::;;:;;::;::;;::;;:;;::;:;;
    		      	
    		      	
    		      	
    		      	
    		      	
    		      	
