(defpackage advent-of-code-2022/day-6
  (:use :cl))

(in-package advent-of-code-2022/day-6)

(defun get-data (path)
  (with-open-file (in path :direction :input :if-does-not-exist nil)
    (loop :for line = (read-line in nil nil) :while line :collect line)))

(defun is-start-marker-p (str &key (num 4))
  (when (> num (length str))
    (return-from is-start-marker-p nil))

  (let ((set ()))
    (dotimes (x num)
      (setf set (adjoin (subseq str x (1+ x)) set :test #'equal)))
    (= (length set) num)))

(defun part-1 (path &key (num 4))
  (let* ((data (car (get-data path)))
         (segments (loop :for x :from 0 :to (length data) :collect (subseq data x (min (length data) (+ num x)))))
         (count 0))
    (dolist (segment segments)
      (when (is-start-marker-p segment :num num)
        (return-from part-1 (+ num count)))
      (incf count))))

(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-1.txt")
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-2.txt")
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-3.txt")
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6-example-4.txt")

(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6.txt")
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-6.txt" :num 14)
