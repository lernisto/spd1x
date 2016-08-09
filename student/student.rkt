;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname student) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; student.rkt

;; =================
;; Data definitions:
#;
("PROBLEM A:

Design a data definition to help a teacher organize their next field trip. 
On the trip, lunch must be provided for all students. For each student, track 
their name, their grade (from 1 to 12), and whether or not they have allergies.
")

(define-struct student (name grade allergic))
;; Student is (make-student name grade allergic)
;; - String name - the student's name
;; - Natural[1,12] grade - the student's grade level
;; - Boolean allergic  - whether the student has allergies
(define S1 (make-student "Jon Do" 3 #f))
(define S2 (make-student "Marty McFly" 12 #t)) ; allergic to school

#;
(define (fn-for-student s)
  (... (student-name s)
       (student-grade s)
       (student-allergic s)))
;; Template rules used:
;; - compound: 3 fields

  


;; =================
;; Functions:
#;
("PROBLEM B:

To plan for the field trip, if students are in grade 6 or below, the teacher 
is responsible for keeping track of their allergies. If a student has allergies, 
and is in a qualifying grade, their name should be added to a special list. 
Design a function to produce true if a student name should be added to this list.
")

