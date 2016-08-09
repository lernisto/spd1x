#lang racket/base
(require pollen/tag)
(provide (all-defined-out))
(define (image file caption)
  `(img ((src ,file)(alt ,caption))))
