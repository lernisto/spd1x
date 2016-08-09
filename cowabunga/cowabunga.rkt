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

(define-struct cow (x dx))
;; CowState is (make-cow x dx)
;; - Natural[0,WIDTH] x - x position of cow in screen coordinates
;; - Integer dx - speed and direction in pixels per tick
(define CSLP (make-cow LEFT-FENCE 1))
(define CSLN (make-cow LEFT-FENCE -1))
(define CSCZ (make-cow CTR-X 0))
(define CSRP (make-cow RIGHT-FENCE 1))
(define CSRN (make-cow RIGHT-FENCE -1))

#;
(define (fn-for-cow cs)
  (... (cow-x cs)   ; Natural[0,WIDTH]
       (cow-dx cs)  ; Integer
       ))
;; template rules used
;; - compound: 2 fields


;; =================
;; Functions:

;; CowState → CowState
;; start the world with (main CS1)
;;
(define (main ws)
  (big-bang ws                   ; CowState
            (on-tick   next-cow)     ; CowState → CowState
            (to-draw   render-cow)   ; CowState → Image
            #;(stop-when ...)      ; CowState → Boolean
            #;(on-mouse  ...)      ; CowState Integer Integer MouseEvent → CowState
            (on-key handle-key)))    ; CowState KeyEvent → CowState

;; CowState → CowState
;; produce the next state by adding dx to x, reversing direction at a fence
(check-expect (next-cow CSCZ) CSCZ) ;; dx == 0, don't move
(check-expect (next-cow CSLN) CSLP) ;; left-end → reverse
(check-expect (next-cow CSRP) CSRN) ;; right-end → reverse
;; normal motion
(check-expect (next-cow (make-cow CTR-X 1)) (make-cow (+ CTR-X 1) 1))
(check-expect (next-cow (make-cow CTR-X -1)) (make-cow (+ CTR-X -1) -1))


;;(define (tock ws) #f); stub

;; workaround for missing `let`
(define (_tocklet cs np x dx)
  (cond
    [(< np LEFT-FENCE)   (make-cow LEFT-FENCE  (- dx))]
    [(> np RIGHT-FENCE)  (make-cow RIGHT-FENCE (- dx))]
    [(= 0 dx)            cs]
    [else                (make-cow np dx)]
    ))

;; template from CowState
(define (next-cow cs)
  (_tocklet
   cs
   (+ (cow-x cs) (cow-dx cs))
   (cow-x cs)
   (cow-dx cs)))

;; CowState → Image
;; render the Cow at x, facing left iff dx < 0
(check-expect (render-cow CSLP) (place-image IMG-RIGHT LEFT-FENCE CTR-Y MTS))
(check-expect (render-cow CSLN) (place-image IMG-LEFT LEFT-FENCE CTR-Y MTS))
(check-expect (render-cow CSRP) (place-image IMG-RIGHT RIGHT-FENCE CTR-Y MTS))
(check-expect (render-cow CSRN) (place-image IMG-LEFT RIGHT-FENCE CTR-Y MTS))

;(define (render ws) MTS) ; stub

;; template from CowState
(define (render-cow cs)
  (place-image (choose-image cs)
               (cow-x cs) CTR-Y
               MTS))

;; CowState → Image
;; choose the correct image, based on direction of travel
(check-expect (choose-image CSLP) IMG-RIGHT)
(check-expect (choose-image CSLN) IMG-LEFT)

;; template from CowState
(define (choose-image cs)
  (if (< (cow-dx cs) 0) IMG-LEFT IMG-RIGHT))

;; CowState → CowState
;; reverse the direction the cow is traveling
(check-expect (reverse-cow CSLP) CSLN)
(check-expect (reverse-cow CSCZ) CSCZ)

(define (reverse-cow cs)
  (make-cow
   (cow-x cs)
   (- (cow-dx cs))))

;; CowState → CowState
;; increase the cow speed by one
(check-expect (faster-cow CSLP) (make-cow LEFT-FENCE 2))
(check-expect (faster-cow CSLN) (make-cow LEFT-FENCE -2))

(define (faster-cow cs)
  (make-cow
   (cow-x cs)
   (+ (if (< (cow-dx cs) 0)
          -1 1)
      (cow-dx cs))))

;; CowState → CowState
;; decrease the cow speed by one
(check-expect (slower-cow CSLN) (make-cow LEFT-FENCE 0))
(check-expect (slower-cow CSLP) (make-cow LEFT-FENCE 0))
(check-expect (slower-cow CSCZ) CSCZ)

(define (slower-cow cs)
  (make-cow
   (cow-x cs)
   (+ (cond [(< (cow-dx cs) 0) 1]
            [(> (cow-dx cs) 0) -1]
            [else 0])
      (cow-dx cs))))

;; CowState → CowState
;; stop the cow (dx=0)
(check-expect (stop-cow CSLP) (make-cow LEFT-FENCE 0))

(define (stop-cow cs)
  (make-cow
   (cow-x cs)
   0))


;; CowState KeyEvent → CowState
;; make the cow reverse direction when space is pressed
(check-expect (handle-key CSLP " ") CSLN)
(check-expect (handle-key CSLN " ") CSLP)
(check-expect (handle-key CSCZ " ") CSCZ)
(check-expect (handle-key CSLP "s") (make-cow LEFT-FENCE 0))
(check-expect (handle-key CSLP "down") (make-cow LEFT-FENCE 0))
(check-expect (handle-key CSLN "down") (make-cow LEFT-FENCE 0))
(check-expect (handle-key CSLP "up") (make-cow LEFT-FENCE 2))
(check-expect (handle-key CSLN "up") (make-cow LEFT-FENCE -2))
(check-expect (handle-key CSCZ "q") (stop-with CSCZ))

(check-expect (handle-key CSLP "a") CSLP)

;;(define (handle-key ws ke) ws) ; stub

;; <template from HtDW>

(define (handle-key ws ke)
  (cond [(key=? ke " ") (reverse-cow ws)]
        [(key=? ke "down") (slower-cow ws)]
        [(key=? ke "up") (faster-cow ws)]
        [(key=? ke "s") (stop-cow ws)]
        [(key=? ke "q") (stop-with ws)]
        [else ws]))
