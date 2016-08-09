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
(define MTS (empty-scene WIDTH HEIGHT))
(define RADIUS 40)
(define SPRITE
  #;(bitmap "lambda.png")
  (overlay
   (radial-star 5 (* RADIUS 1/2) (* RADIUS 1) 'solid 'white)
   (circle RADIUS 'solid 'blue)))
(define MIN-X (/ (image-width SPRITE) 2))
(define MAX-X (- WIDTH (/ (image-width SPRITE) 2)))
(define CTR-Y (/ HEIGHT 2))

;; =================
;; Data definitions:

(define-struct sprite (x θ dx dθ))
;; Sprite is (make-sprite x θ dx dθ )
;; - x Natural[0,WIDTH) screen x-coordinate in pixels
;; - θ - Number[0,360) angle of rotation in degrees
;; - dx Integer change in x in pixels per tick
;; - dθ - Number[0,360) change in θ degrees per tick
(define S0 (make-sprite MIN-X 0 3 -3))
(define S1 (make-sprite MAX-X 0 -3 3)) 

#;
(define (fn-for-sprite s)
  (...
   (sprite-x s) ; Natural[0,WIDTH]
   (sprite-θ s) ; Number[0,360)
   (sprite-dx s) ; Integer
   (sprite-dθ s) ; Number[0,360)
   ))
;; template rules used
;; - compound: 2 fields
;; - simple atomic: Natural[0,WIDTH]
;; - simple atomic: Number[0,360)
;; - simple atomic: Integer
;; - simple atomic: Number[0,360)

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
            (on-mouse  handle-mouse)      ; Sprite Integer Integer MouseEvent -> Sprite
            (on-key    handle-key)))    ; Sprite KeyEvent -> Sprite

;; Sprite -> Sprite
;; produce the next position for the sprite: x+=dx
;;   reverse direction when reaching a fence
(check-expect (next-sprite (make-sprite 80 0 3 -3)) (make-sprite 83 357 3 -3)) ;; normal motion
(check-expect (next-sprite (make-sprite MAX-X 0 3 -3)) (make-sprite MAX-X 0 -3 3)) ;; reverse at right end
(check-expect (next-sprite (make-sprite MIN-X 0 -3 -3)) (make-sprite MIN-X 0 3 3)) ;; reverse at left end

;(define (next-sprite ws) ws) ;stub
;; template from Sprite
(define (next-sprite s)
  (cond
    [(> (+ (sprite-x s) (sprite-dx s)) MAX-X)
     (make-sprite
      MAX-X
      (sprite-θ s) ;; !!! not exact
      (- (sprite-dx s))
      (- (sprite-dθ s))
      )]
    [(< (+ (sprite-x s) (sprite-dx s)) MIN-X)
     (make-sprite
      MIN-X
      (sprite-θ s) ;; !!! not exact
      (- (sprite-dx s))
      (- (sprite-dθ s))
      )]
    [else
     (make-sprite
      (+ (sprite-x s) (sprite-dx s))
      (modulo (+ (sprite-θ s) (sprite-dθ s)) 360)
      (sprite-dx s)
      (sprite-dθ s)
      )]
    ))


;; Sprite -> Image
;; place the sprite image at x,CTR-Y on MTS
(check-expect (render-sprite S0) (place-image SPRITE (sprite-x S0) CTR-Y MTS))

;(define (render-sprite ws) MTS); stub
;; template from Sprite
(define (render-sprite s)
  (place-image (rotate (sprite-θ s) SPRITE)
               (sprite-x s)
               CTR-Y
               MTS))

;; Sprite KeyEvent -> Sprite
;; restart the animation when ' ' is pressed
(check-expect (handle-key S1 " ") S0)
(check-expect (handle-key S1 "a") S1)

(define (handle-key ws ke)
  (cond [(key=? ke " ") S0]
        [else ws]))

;; Sprite Integer Integer MouseEvent -> Sprite
;; reverse the direction of travel when mouse is clicked
(check-expect (handle-mouse S1 0 0 "button-down") (reverse-sprite S1))
(check-expect (handle-mouse S1 0 0 "move") S1)

(define (handle-mouse ws x y me)
  (cond [(mouse=? me "button-down") (reverse-sprite ws)]
        [else ws]))

;; Sprite -> Sprite
;; reverse the direction of travel of the sprite
(check-expect (reverse-sprite (make-sprite 0 0 1 -1)) (make-sprite 0 0 -1 1))

;(define (reverse-sprite s) s);stub

;; template from Sprite
(define (reverse-sprite s)
  (make-sprite
   (sprite-x s) ; Natural[0,WIDTH]
   (sprite-θ s) ; Number[0,360)
   (- (sprite-dx s)) ; Integer
   (- (sprite-dθ s)) ; Number[0,360)
   ))

