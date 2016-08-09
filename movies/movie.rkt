;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname movie) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; movie.rkt

;; =================
;; Data definitions:
#;
("PROBLEM A:

Design a data definition to represent a movie, including  
title, budget, and year released.
")

(define-struct movie (name budget year))
;; Movie is (make-movie String Number Natural)
;; interp. a movie with
;;  - String name - the name of the movie
;;  - Number budget - estimated budget in US Dollars
;;  - Natural year - the year A.D. of the public release
(define M1 (make-movie "Inside Out" 175000000 2015))
(define M2 (make-movie "Up"         175000000 2009))
(define M3 (make-movie "How to Train your Dragon" 165000000 2010))

#;
(define (fn-for-movie m)
  (... (movie-name m)    ;String
       (movie-budget m)  ;Number
       (movie-year m)))  ;Natural
;; Template rules used:
;;  - compound: 3 fields

;; =================
;; Functions:
#;
("PROBLEM B:

You have a list of movies you want to watch, but you like to watch your 
rentals in chronological order. Design a function that consumes two movies 
and produces the title of the most recently released movie.

Note that the rule for templating a function that consumes two compound data 
parameters is for the template to include all the selectors for both 
parameters.")
