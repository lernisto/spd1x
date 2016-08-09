;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cowabunga) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


#;
("
PROBLEM:

As we learned in the cat world programs, cats have a mind of their own. When they 
reach the edge they just keep walking out of the window.

Cows on the other hand are docile creatures. They stay inside the fence, walking
back and forth nicely.

Design a world program with the following behaviour:
   - A cow walks back and forth across the screen.
   - When it gets to an edge it changes direction and goes back the other way
   - When you start the program it should be possible to control how fast a
     walker your cow is.
   - Pressing space makes it change direction right away.
   
To help you here are two pictures of the right and left sides of a lovely cow that 
was raised for us at Brown University.

Once your program works here is something you can try for fun. If you rotate the
images of the cow slightly, and you vary the image you use as the cow moves, you
can make it appear as if the cow is waddling as it walks across the screen.

Also, to make it look better, arrange for the cow to change direction when its
nose hits the edge of the window, not the center of its body."
 )

;; animated cow

;; =================
;; Constants:
(define WIDTH 600)
(define HEIGHT 200)
(define MTS (empty-scene WIDTH HEIGHT))
(define IMG-RIGHT (bitmap "right-face.png"))
(define IMG-LEFT (bitmap "left-face.png"))
(define IMG-WIDTH (max (image-width IMG-LEFT) (image-width IMG-RIGHT)))
(define LEFT-FENCE (+ 2 (* 1/2 IMG-WIDTH)))
(define RIGHT-FENCE (- WIDTH (* 1/2 IMG-WIDTH) 2))
(define CTR-Y (* 1/2 HEIGHT))
(define CTR-X (* 1/2 WIDTH))

;; ==================
;; Variable state:

(define-struct cow-state (xpos velocity))
;; CowState is (make-cow-state xpos velocity)
;; - Natural xpos - x position of Cow in screen coordinates 
;; - Integer velocity - speed and direction in pixels per tick
(define CS1 (make-cow-state LEFT-FENCE 1))
(define CS2 (make-cow-state LEFT-FENCE -1))
(define CS3 (make-cow-state CTR-X 0))
(define CS4 (make-cow-state RIGHT-FENCE 1))
(define CS5 (make-cow-state RIGHT-FENCE -1))

#;
(define (fn-for-cow-state cs)
  (... (cow-state-xpos cs)
       (cow-state-velocity cs)))
;; template rules used
;; - compound: 2 fields


;; =================
;; Functions:

;; CowState -> CowState
;; start the world with (main CS1)
;; 
(define (main ws)
  (big-bang ws                   ; CowState
            (on-tick   tock)     ; CowState -> CowState
            (to-draw   render)   ; CowState -> Image
            #;(stop-when ...)      ; CowState -> Boolean
            #;(on-mouse  ...)      ; CowState Integer Integer MouseEvent -> CowState
            #;(on-key    ...)))    ; CowState KeyEvent -> CowState

;; CowState -> CowState
;; produce the next state by adding velocity to xpos, reversing direction at a fence
(check-expect (tock CS3) CS3) ;; velocity == 0, don't move
(check-expect (tock CS2) CS1) ;; left-end -> reverse
(check-expect (tock CS4) CS5) ;; right-end -> reverse
;; normal motion
(check-expect (tock (make-cow-state CTR-X 1)) (make-cow-state (+ CTR-X 1) 1))
(check-expect (tock (make-cow-state CTR-X -1)) (make-cow-state (+ CTR-X -1) -1))


;;(define (tock ws) #f); stub

;; workaround for missing `let`
(define (_tocklet cs np x v)
  (cond
    [(< np LEFT-FENCE)
     (make-cow-state LEFT-FENCE (abs v))]
    [(> np RIGHT-FENCE)
     (make-cow-state RIGHT-FENCE (- (abs v)))]
    [(= 0 v) cs]
    [else
     (make-cow-state np v)]
    ))

;; template from CowState
(define (tock cs)
  (_tocklet
   cs
   (+ (cow-state-xpos cs) (cow-state-velocity cs))
   (cow-state-xpos cs)
   (cow-state-velocity cs)))

;; CowState -> Image
;; render the Cow at xpos, facing left iff velocity < 0
(check-expect (render CS1) (place-image IMG-RIGHT LEFT-FENCE CTR-Y MTS))
(check-expect (render CS2) (place-image IMG-LEFT LEFT-FENCE CTR-Y MTS))
(check-expect (render CS4) (place-image IMG-RIGHT RIGHT-FENCE CTR-Y MTS))
(check-expect (render CS5) (place-image IMG-LEFT RIGHT-FENCE CTR-Y MTS))

;(define (render ws) MTS) ; stub

;; template from CowState
(define (render cs)
  (place-image (if (< (cow-state-velocity cs) 0)
                   IMG-LEFT
                   IMG-RIGHT)
               (cow-state-xpos cs) CTR-Y
               MTS))
