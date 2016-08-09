;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname water-balloon) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;; water-balloon.rkt


#;
("
PROBLEM:

In this problem, we will design an animation of throwing a water balloon.
When the program starts the water balloon should appear on the left side
of the screen, half-way up.  Since the balloon was thrown, it should
fly across the screen, rotating in a clockwise fashion. Pressing the
space key should cause the program to start over with the water balloon
back at the left side of the screen.

NOTE: Please include your domain analysis at the top in a comment box.

Use the following images to assist you with your domain analysis:")

#;
("

NOTE: The rotate function wants an angle in degrees as its first
argument. By that it means Number[0, 360). As time goes by your balloon
may end up spinning more than once, for example, you may get to a point
where it has spun 362 degrees, which rotate won't accept.

The solution to that is to use the modulo function as follows:

(rotate (modulo ... 360) (text \"hello\" 30 'black))

where ... should be replaced by the number of degrees to rotate.

NOTE: It is possible to design this program with simple atomic data,
but we would like you to use compound data.
")


;; Water balloon animation

;; =================
;; Constants:
(define WIDTH 640)
(define HEIGHT 480)
(define MTS (empty-scene WIDTH HEIGHT))
(define BALLOON0 (bitmap "ballon.png"))
(define CTR-Y (* 1/2 HEIGHT)) ;; hmm… no gravity.


;; =================
;; Data definitions:

(define-struct balloon (x y θ dx dy dθ))
;; Ballon is (make-balloon x y θ dx dy dθ)
;; - x - Natural[0,WIDTH] screen x position of center of balloon
;; - y - Natural[0,HEIGHT] screen y position of center of balloon
;; - θ - Number[0,360) angle of rotation in degrees
;; - dx - Integer change in x pixels per tick
;; - dy - Integer change in y pixels per tick
;; - dθ - Number[0,360) change in θ degrees per tick
(define BSTART (make-balloon 0 CTR-Y 0 3 0 3))

(define (fn-for-ballon bs)
  (...
    (balloon-x bs)  ; Natural[0,WIDTH]
    (balloon-y bs)  ; Natural[0,HEIGHT]
    (balloon-θ bs)  ; Number[0,360)
    (balloon-dx bs) ; Integer
    (balloon-dy bs) ; Integer
    (balloon-dθ bs) ; Number[0,360)
    )
)
;; template rules used:
;; - compound: 6 fields


;; =================
;; Functions:

;; Balloon -> Balloon
;; start the world with (main BSTART)
;;
(define (main ws)
  (big-bang ws                   ; Balloon
            (on-tick   next-balloon)     ; Balloon -> Balloon
            (to-draw   render-balloon)   ; Balloon -> Image
            #;(stop-when ...)      ; Balloon -> Boolean
            #;(on-mouse  ...)      ; Balloon Integer Integer MouseEvent -> Balloon
            #;(on-key    ...)))    ; Balloon KeyEvent -> Balloon

;; Balloon -> Balloon
;; produce the next position and rotation of the balloon
;; !!!
(define (next-balloon ws) ws)


;; Balloon -> Image
;; render the ballon at x,y in MTS rotated by θ
;; !!!
(define (render-balloon ws) MTS)
