;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; cat.rkt

#;
("PROBLEM:

Use the How to Design Worlds recipe to design an interactive
program in which a cat starts at the left edge of the display 
and then walks across the screen to the right. When the cat
reaches the right edge it should just keep going right off 
the screen.

Once your design is complete revise it to add a new feature,
which is that pressing the space key should cause the cat to
go back to the left edge of the screen. When you do this, go
all the way back to your domain analysis and incorporate the
new feature.

To help you get started, here is a picture of a cat, which we
have taken from the 2nd edition of the How to Design Programs 
book on which this course is based.
")


(require 2htdp/image)
(require 2htdp/universe)

;; A cat that moves from left to right across the scene

;; =================
;; Constants:
(define WIDTH 400)
(define HEIGHT 200)
(define MTS (empty-scene WIDTH HEIGHT))
(define CAT-Y (/ HEIGHT 2))
(define CAT-IMG (bitmap "cat1.png"))
(define CAT-SPEED 3) ; pixels per tick

;; =================
;; Data definitions:


;; CatX is Number
;; interp. the x position of the cat image in screen coordinates
(define CATX0 0)            ;left edge
(define CATX1 (/ WIDTH 2))  ;middle
(define CATX2 WIDTH)        ;right edge

#;
(define (fn-for-cat-x catx)
  (... catx))

;; Template rules used:
;;  - atomic non-distinct: Number


;; =================
;; Functions:


;; CatX -> CatX
;; start the world with (main 0)
(define (main catx)
  (big-bang catx                 ; CatX
            (on-tick advance-cat); CatX -> CatX
            (to-draw   render)   ; CatX -> Image
            #;
            (stop-when ...)      ; CatX -> Boolean
            #;
            (on-mouse  ...)      ; CatX Integer Integer MouseEvent -> CatX
            #;
            (on-key    ...)))    ; CatX KeyEvent -> CatX

;; CatX -> CatX
;; produce the next position of the Cat
(check-expect (advance-cat 0) CAT-SPEED)

;(define (advance-cat catx) 0) ;stub

;; <use template from CatX>
(define (advance-cat catx)
  (+ CAT-SPEED catx))


;; CatX -> Image
;; render the cat at the specified x position on the empty scene.
(check-expect (render CATX0) (place-image CAT-IMG CATX0 CAT-Y MTS))

; (define (render catx) ...) stub

;; <use template from CatX>
(define (render catx)
  (place-image CAT-IMG catx CAT-Y MTS))

