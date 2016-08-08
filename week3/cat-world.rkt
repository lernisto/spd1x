;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cat-world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define MTS (empty-scene 400 200))
(define CAT (bitmap "cat1.png"))
(define Y (/ (image-height MTS) 2))


(define (render-cat x)
  (place-image CAT x Y MTS))


(overlay
 (circle 50 'outline 'blue)
 CAT
 (render-cat 50))
#;
(big-bang 0
          (on-tick (λ (x) (+ 3 x)))
          (to-draw render-cat))