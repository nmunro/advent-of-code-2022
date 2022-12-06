(defpackage advent-of-code-2022/day-6
  (:use :cl))

(in-package advent-of-code-2022/day-6)

(defun get-data (path)
  (with-open-file (in path :direction :input :if-does-not-exist nil)
    (loop :for line = (read-line in nil nil) :while line :collect line)))

(defun is-start-marker-p (str)
  (when (> 4 (length str))
    (return-from is-start-marker-p nil))

  (format t "~A~%" str)
  (and (not (string-equal (subseq str 0 1) (subseq str 3 4)))
       (not (string-equal (subseq str 0 1) (subseq str 2 3)))
       (not (string-equal (subseq str 0 1) (subseq str 1 2)))
       (not (string-equal (subseq str 0 1) (subseq str 1 2)))
       (not (string-equal (subseq str 1 2) (subseq str 2 3)))
       (not (string-equal (subseq str 1 2) (subseq str 3 4)))
       (not (string-equal (subseq str 2 3) (subseq str 3 4)))))

(defun part-1 (path)
  (let* ((data (car (get-data path)))
         (segments (loop :for x :from 0 :to (length data) :collect (subseq data x (min (length data) (+ 4 x)))))
         (count 0))
    (dolist (segment segments)
      (when (is-start-marker-p segment)
        (return-from part-1 (+ 4 count)))
      (incf count))))

(defun part-2 (path)
  (let ((data (car (get-data path))))
    data))

(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-1.txt")
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-2.txt")
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-3.txt")
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-4.txt")

(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6.txt")
(part-2 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6.txt")

;; Tests
(is-start-marker-p "aaaa")
(is-start-marker-p "aaab")
(is-start-marker-p "aabc")
(is-start-marker-p "abcd")
(is-start-marker-p "abab")
(is-start-marker-p "abba")
