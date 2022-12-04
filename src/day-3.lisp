(defpackage advent-of-code-2022/day-3
  (:use :cl))

(in-package advent-of-code-2022/day-3)

(defconstant +priority+ "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

(defun get-data (path)
  (with-open-file (in path :direction :input :if-does-not-exist nil)
    (loop :for line = (read-line in nil nil) :while line :collect line)))

(defun split-item (item)
  (let ((midpoint (/ (length item) 2)))
    `(,(subseq item 0 midpoint) ,(subseq item midpoint))))

(defun find-intersection (item1 item2)
  (car (intersection (coerce item1 'list) (coerce item2 'list))))

(let ((items (get-data #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-3.txt")))
  (loop :for item :in items :summing (1+ (position (apply #'find-intersection (split-item item)) +priority+ :test #'equal))))
