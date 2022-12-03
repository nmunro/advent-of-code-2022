(defpackage advent-of-code-2022/day-2
  (:use :cl))

(in-package advent-of-code-2022/day-2)

(defun compare (opponent player)
  (cond
    ((and (equal opponent "A") (equal player "X")) ; draw 3 + 1 (rock)
     4)

    ((and (equal opponent "A") (equal player "Y")) ; win 6 + 2 (paper)
     8)

    ((and (equal opponent "A") (equal player "Z")) ; loose 0 + 3 (scissors)
     3)

    ((and (equal opponent "B") (equal player "X")) ; loose 0 + 1 (rock)
     1)

    ((and (equal opponent "B") (equal player "Y")) ; draw 3 + 2 (paper)
     5)

    ((and (equal opponent "B") (equal player "Z")) ; win 6 + 3 (scissors)
     9)

    ((and (equal opponent "C") (equal player "X")) ; win 6 + 1 (rock)
     7)

    ((and (equal opponent "C") (equal player "Y")) ; loose 0 + 2 (paper)
     2)

    ((and (equal opponent "C") (equal player "Z")) ; draw 3 + 3 (scissors)
     6)

    (t
     (error "Something went wrong"))))

(defun determine-match-up (opponent condition)
  (cond
    ((and (equal opponent "A") (equal condition "X")) ; loose
     3)

    ((and (equal opponent "A") (equal condition "Y")) ; draw
     4)

    ((and (equal opponent "A") (equal condition "Z")) ; win
     8)

    ((and (equal opponent "B") (equal condition "X"))
     1)

    ((and (equal opponent "B") (equal condition "Y"))
     5)

    ((and (equal opponent "B") (equal condition "Z"))
     9)

    ((and (equal opponent "C") (equal condition "X"))
     2)

    ((and (equal opponent "C") (equal condition "Y"))
     6)

    ((and (equal opponent "C") (equal condition "Z"))
     7)

    (t
     (error "Something went wrong"))))

(defun get-input (path)
  (with-open-file (in path :direction :input :if-does-not-exist nil)
    (loop :for line = (read-line in nil nil) :while line :collect line)))

(defun part-1 (path)
  (let ((rounds (get-input path)))
    (loop :for round :in rounds :summing (apply #'compare (uiop:split-string round :separator " ")))))

(defun part-2 (path)
  (let ((rounds (get-input path)))
    (loop :for round :in rounds :summing (apply #'determine-match-up (uiop:split-string round :separator " ")))))

(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-2.txt")
(part-2 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-2.txt")
