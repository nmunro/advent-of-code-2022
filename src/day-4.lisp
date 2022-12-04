(defpackage advent-of-code-2022/day-4
  (:use :cl))

(in-package advent-of-code-2022/day-4)

(defun get-data (path)
  (with-open-file (in path :direction :input :if-does-not-exist nil)
    (loop :for line = (read-line in nil nil) :while line :collect line)))

(defun split-pairs (pairs)
  (uiop:split-string pairs :separator ","))

(defun split-sections (pair1 pair2)
  `(,(uiop:split-string pair1 :separator "-") ,(uiop:split-string pair2 :separator "-")))

(defun make-range (item)
  (loop :for x :from (parse-integer (car item)) :to (parse-integer (cadr item)) :collect x))

(defun make-ranges (items)
  (loop :for item :in items :collect `(,(make-range (car item)) ,(make-range (cadr item)))))

(defun order-ranges (ranges)
  (loop :for range :in ranges
        :if (> (length (car range)) (length (cadr range)))
          :collect `(,(car range) ,(cadr range))
        :else
          :collect `(,(cadr range) ,(car range))))

(defun part-1 (path)
  (let* ((data (loop :for pair :in (get-data path) :collect (apply #'split-sections (split-pairs pair))))
         (ranges (order-ranges (make-ranges data))))
    (length (loop :for range :in ranges :if (search (cadr range) (car range)) :collect t))))

(defun part-2 (path)
  (probe-file path))

;; if one if fully contained in the other, not if they share some work
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-4.txt")
(part-2 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-4.txt")
