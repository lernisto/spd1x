;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; countdown.rkt

#;
("PROBLEM:

Design an animation of a simple countdown. 

Your program should display a simple countdown, that starts at ten, and
decreases by one each clock tick until it reaches zero, and stays there.

To make your countdown progress at a reasonable speed, you can use the 
rate option to on-tick. If you say, for example, 
(on-tick advance-countdown 1) then big-bang will wait 1 second between 
calls to advance-countdown.

Remember to follow the HtDW recipe! Be sure to do a proper domain 
analysis before starting to work on the code file.

Once you are finished the simple version of the program, you can improve
it by reseting the countdown to ten when you press the spacebar.")
