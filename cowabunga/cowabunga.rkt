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
(define CSLP (make-cow-state LEFT-FENCE 1))
(define CSLN (make-cow-state LEFT-FENCE -1))
(define CSCZ (make-cow-state CTR-X 0))
(define CSRP (make-cow-state RIGHT-FENCE 1))
(define CSRN (make-cow-state RIGHT-FENCE -1))

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
            (on-key handle-key)))    ; CowState KeyEvent -> CowState

;; CowState -> CowState
;; produce the next state by adding velocity to xpos, reversing direction at a fence
(check-expect (tock CSCZ) CSCZ) ;; velocity == 0, don't move
(check-expect (tock CSLN) CSLP) ;; left-end -> reverse
(check-expect (tock CSRP) CSRN) ;; right-end -> reverse
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
(check-expect (render CSLP) (place-image IMG-RIGHT LEFT-FENCE CTR-Y MTS))
(check-expect (render CSLN) (place-image IMG-LEFT LEFT-FENCE CTR-Y MTS))
(check-expect (render CSRP) (place-image IMG-RIGHT RIGHT-FENCE CTR-Y MTS))
(check-expect (render CSRN) (place-image IMG-LEFT RIGHT-FENCE CTR-Y MTS))

;(define (render ws) MTS) ; stub

;; template from CowState
(define (render cs)
  (place-image (if (< (cow-state-velocity cs) 0)
                   IMG-LEFT
                   IMG-RIGHT)
               (cow-state-xpos cs) CTR-Y
               MTS))

;; CowState -> CowState
;; reverse the direction the cow is traveling
(check-expect (reverse-cow-state CSLP) CSLN)
(check-expect (reverse-cow-state CSCZ) CSCZ)

(define (reverse-cow-state cs)
  (make-cow-state
   (cow-state-xpos cs)
   (- (cow-state-velocity cs))))

;; CowState -> CowState
;; increase the cow speed by one
(check-expect (faster-cow-state CSLP) (make-cow-state LEFT-FENCE 2))
(check-expect (faster-cow-state CSLN) (make-cow-state LEFT-FENCE -2))

(define (faster-cow-state cs)
  (make-cow-state
   (cow-state-xpos cs)
   (+ (if (< (cow-state-velocity cs) 0)
      -1 1)
      (cow-state-velocity cs))))

;; CowState -> CowState 
;; decrease the cow speed by one
(check-expect (slower-cow-state CSLN) (make-cow-state LEFT-FENCE 0))
(check-expect (slower-cow-state CSLP) (make-cow-state LEFT-FENCE 0))
(check-expect (slower-cow-state CSCZ) CSCZ)

(define (slower-cow-state cs)
  (make-cow-state
   (cow-state-xpos cs)
   (+ (cond [(< (cow-state-velocity cs) 0) 1]
            [(> (cow-state-velocity cs) 0) -1]
            [else 0])
      (cow-state-velocity cs))))

;; CowState -> CowState
;; stop the cow (velocity=0)
(check-expect (stop-cow-state CSLP) (make-cow-state LEFT-FENCE 0))

(define (stop-cow-state cs)
  (make-cow-state
   (cow-state-xpos cs)
   0))


;; CowState KeyEvent -> CowState
;; make the cow reverse direction when space is pressed
(check-expect (handle-key CSLP " ") CSLN)
(check-expect (handle-key CSLN " ") CSLP)
(check-expect (handle-key CSCZ " ") CSCZ)
(check-expect (handle-key CSLP "s") (make-cow-state LEFT-FENCE 0))
(check-expect (handle-key CSLP "down") (make-cow-state LEFT-FENCE 0))
(check-expect (handle-key CSLN "down") (make-cow-state LEFT-FENCE 0))
(check-expect (handle-key CSLP "up") (make-cow-state LEFT-FENCE 2))
(check-expect (handle-key CSLN "up") (make-cow-state LEFT-FENCE -2))
(check-expect (handle-key CSCZ "q") (stop-with CSCZ))

(check-expect (handle-key CSLP "a") CSLP)

;;(define (handle-key ws ke) ws) ; stub

;; <template from HtDW>

(define (handle-key ws ke)
  (cond [(key=? ke " ") (reverse-cow-state ws)]
        [(key=? ke "down") (slower-cow-state ws)]
        [(key=? ke "up") (faster-cow-state ws)]
        [(key=? ke "s") (stop-cow-state ws)]
        [(key=? ke "q") (stop-with ws)]
        [else ws]))
