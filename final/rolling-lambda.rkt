;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rolling-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; rolling-lambda.rkt

(define SPRITE (bitmap "lambda.png"))

#;("
PROBLEM:

Design a world program as follows:

The world starts off with a sprite on the left hand side of the screen. As 
time passes, the sprite will roll towards the right hand side of the screen. 
Clicking the mouse changes the direction the sprite is rolling (ie from 
left -> right to right -> left). If the sprite hits the side of the window 
it should also change direction.
")

#;("
STEP 1:
Just make the sprite slide back and forth across the screen without rolling.
")


#;("
STEP 2:
Make the sprite spin as it slides, but don't worry about making the spinning
be just exactly right to make it look like its rolling. Just have it 
spinning and sliding back and forth across the screen.
")

#;("
STEP 3:
Work out the math you need to in order to make the sprite look like it is
actually rolling.
")

#;("
STEP 4:
Make the sprite roll down an inclined plane.
")

#;("
STEP 5:
Make the sprite accelerate as it rolls down the plane.
")


#;("
STEP 6:
Place the sprite in bowl. Maximum speed will be at the bottom of the bowl.
Have it slow down as it converts kinetic energy into potential energy
climbing the other side of the bowl.
")

