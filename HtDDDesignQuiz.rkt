;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDDDesignQuiz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDD Design Quiz

;; Age is Natural
;; interp. the age of a person in years
(define A0 18)
(define A1 25)

#;
(define (fn-for-age a)
  (... a))

;; Template rules used:
;; - atomic non-distinct: Natural


#;
("
Problem 1:

Consider the above data definition for the age of a person.

Design a function called teenager? that determines whether a person
of a particular age is a teenager (i.e., between the ages of 13 and 19).
")

;; Age -> Boolean
;; produces true iff age is in [13, 19]

(check-expect (teenager? 12) #f)
(check-expect (teenager? 13) #t)
(check-expect (teenager? 19) #t)
(check-expect (teenager? 20) #f)

; (define (teenager? age) #f) ; stub

; template from data definition for Age
#;
(define (teenager? a)
  (... a))

(define (teenager? a)
  (and (>= a 13) (<= a 19)))



#;
("Problem 2:

Design a data definition called MonthAge to represent a person's age
in months.")

;; MonthAge is Natural
;; interp. the age of a person in months
(define MA0 18)
(define MA1 25)

#;
(define (fn-for-month-age ma)
  (... ma))

;; Template rules used:
;; - atomic non-distinct: Natural


#;
("
Problem 3:

Design a function called months-old that takes a person's age in years 
and yields that person's age in months.
")
;; Age -> MonthAge
;; produce the age in months from the age in years
(check-expect (months-old A0) (* 12 A0))
(check-expect (months-old A1) (* 12 A1))

;(define (months-old a) 0) ; stub

; template from data definition for Age
#;
(define (months-old a)
  (... a))

(define (months-old a)
  (* 12 a))

#;
("Problem 4:

Consider a video game where you need to represent the health of your
character. The only thing that matters about their health is:

  - if they are dead (which is shockingly poor health)
  - if they are alive then they can have 0 or more extra lives

Design a data definition called Health to represent the health of your
character.
")


;; Health is one of:
;; - false
;; - Natural
;; interp. false means dead, Natural is the number of extra lives

(define H0 false) ;; dead
(define H1 5) ;; 5 extra lives

#;
(define (fn-for-health h)
  (cond [(false? h) (...)]
        [else (... h)]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: false
;;  - atomic non-distinct: Natural

#;
("Design a function called increase-health that allows you to increase the
lives of a character.  The function should only increase the lives
of the character if the character is not dead, otherwise the character
remains dead.
")

;; Health Natural -> Health
;; add to the number of extra lives iff the character is not already dead
(check-expect (increase-health H0 3) H0)
(check-expect (increase-health H1 3) 8)

;(define (increase-health h lives) #f) ; stub kills the character first ;)

;; template from data definition for health
#;
(define (increase-health h l)
  (cond [(false? h) (...)]
        [else (... h)]))

(define (increase-health h l)
  (cond [(false? h) h]
        [else (+ h l)]))

;; TODO maybe change sig to Health Health -> Health
