;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; countdown.rkt

#;
("PROBLEM:

Design an animation of a simple countdown. 

Your program should display a simple countdown, that starts at ten, and
decreases by one each clock tick until it reaches zero, and stays there.

To make your countdown progress at a reasonable speed, you can use the 
rate option to on-tick. If you say, for example, 
(on-tick advance-countdown 1) then big-bang will wait 1 second between 
calls to advance-countdown.

Remember to follow the HtDW recipe! Be sure to do a proper domain 
analysis before starting to work on the code file.

Once you are finished the simple version of the program, you can improve
it by reseting the countdown to ten when you press the spacebar.")


;; A countdown timer that displays the number of seconds remaining

;; =================
;; Constants:
(define WIDTH 100)
(define HEIGHT 100)
(define MTS (empty-scene WIDTH HEIGHT))

(define TEXT-SIZE 64)
(define TEXT-COLOR 'black)

(define TEXT-CX (/ 2 WIDTH))
(define TEXT-CY (/ 2 HEIGHT))

;; =================
;; Data definitions:

;; Countdown is Integer[10,0]
;; - Number of seconds remaining
(define START-TIME 10)
(define END-TIME 0)

#;
(define (fn-for-countdown cd)
  (... cd))


;; =================
;; Functions:

;; Countdown -> Countdown
;; start the world with (main 10)
;; 
(define (main ws)
  (big-bang ws                     ; Countdown
            (on-tick   tock 1)     ; Countdown -> Countdown
            (to-draw   render)     ; Countdown -> Image
            #;(stop-when ...)      ; Countdown -> Boolean
            #;(on-mouse  ...)      ; Countdown Integer Integer MouseEvent -> Countdown
            #;(on-key    ...)))    ; Countdown KeyEvent -> Countdown

;; Countdown -> Countdown
;; produce the next state by subtracting 1 second, stop at 0.
(check-expect (tock 0) 0)
(check-expect (tock 1) 0)
(check-expect (tock 10) 9)

;(define (tock ws) 0); stub

;;<template from Countdown>
(define (tock cd)
  (if (<= cd 0) 0 (- cd 1)))


;; Countdown -> Image
;; render the text of remaining seconds in the center of the scene
(check-expect (render 0) (overlay (text (number->string 0) TEXT-SIZE TEXT-COLOR) MTS))

#;(define (render ws) MTS) ; stub

;;<template from Countdown>
(define (render cd)
  (overlay (text (number->string cd) TEXT-SIZE TEXT-COLOR) MTS))

