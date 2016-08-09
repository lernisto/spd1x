#lang racket

(define (double x) (* 2 x))

(define (ldouble l) (map double l))

(ldouble '(2 3 4 5))
