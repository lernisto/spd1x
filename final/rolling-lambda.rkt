;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rolling-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#;
("
PROBLEM:

Design a world program as follows:

The world starts off with a sprite on the left hand side of the screen. As
time passes, the sprite will roll towards the right hand side of the screen.
Clicking the mouse changes the direction the sprite is rolling (ie from
left -> right to right -> left). If the sprite hits the side of the window
it should also change direction.
")

#;
("
STEP 1:
Just make the sprite slide back and forth across the screen without rolling.
")

#;
("
STEP 2:
Make the sprite spin as it slides, but don't worry about making the spinning
be just exactly right to make it look like its rolling. Just have it
spinning and sliding back and forth across the screen.
")

#;
("
STEP 3:
Work out the math you need to in order to make the sprite look like it is
actually rolling.
")

#;
("
STEP 4:
Make the sprite roll down an inclined plane.
")

#;
("
STEP 5:
Make the sprite accelerate as it rolls down the plane.
")

#;
("
STEP 6:
Place the sprite in bowl. Maximum speed will be at the bottom of the bowl.
Have it slow down as it converts kinetic energy into potential energy
climbing the other side of the bowl. Assume no loss due to friction.
")

(require 2htdp/image)
(require 2htdp/universe)

;; Rolling sprite animation

;; =================
;; Constants:
(define WIDTH 600)
(define HEIGHT 200)
(define SPRITE (bitmap "lambda.png"))
(define MIN-X (/ (image-width SPRITE) 2))
(define MAX-X (- WIDTH (/ (image-width SPRITE) 2)))
(define CTR-Y (/ HEIGHT 2))

;; =================
;; Data definitions:

(define-struct sprite (x dx))
;; Sprite is (make-sprite x dx )
;; - x Natural[0,WIDTH) screen x-coordinate in pixels
;; - dx Integer change in x in pixels per tick
(define S0 (make-sprite MIN-X  3))
(define S1 (make-sprite MAX-X -3))

#;
(define (fn-for-sprite s)
  (...
    (sprite-x s) ; Natural[0,WIDTH]
    (sprite-dx s) ; Integer
    ))
;; template rules used
;; - compound: 2 fields
;; - simple atomic: Natural[0,WIDTH]
;; - simple atomic: Integer

;; =================
;; Functions:

;; Sprite -> Sprite
;; start the world with (main S0)
;;
(define (main ws)
  (big-bang ws                   ; Sprite
            (on-tick   next-sprite)     ; Sprite -> Sprite
            (to-draw   render-sprite)   ; Sprite -> Image
            #;(stop-when ...)      ; Sprite -> Boolean
            #;(on-mouse  ...)      ; Sprite Integer Integer MouseEvent -> Sprite
            #;(on-key    ...)))    ; Sprite KeyEvent -> Sprite

;; Sprite -> Sprite
;; produce the next position for the sprite: x+=dx
(check-expect (next-sprite (make-sprite 0 3)) (make-sprite 3 3))

;(define (next-sprite ws) ws) ;stub
;; template from Sprite
(define (next-sprite s)
  (make-sprite
    (+ (sprite-x s) (sprite-dx s))
    (sprite-dx s)
    ))


;; Sprite -> Image
;; render ...
;; !!!
(define (render-sprite ws) ...)
