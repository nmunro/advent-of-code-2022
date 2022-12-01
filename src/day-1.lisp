(defpackage advent-of-code-2022/day-1
  (:use :cl)
  (:export #:find-top-calories))

(in-package advent-of-code-2022/day-1)

(defun get-elfs (path)
  (with-open-file (in path :direction :input :if-does-not-exist nil)
    (split-sequence:split-sequence "" (loop :for line = (read-line in nil nil) :while line :collect line) :test #'equal)))

(defun sum-elf-food (elf)
  (reduce #'+ (loop :for num :in elf :collect (parse-integer num))))

(defun find-top-calories (path &key (max-num 0))
  (let ((elfs (loop :for elf :in (get-elfs path) :collect (sum-elf-food elf))))
    (if (= 0 max-num)
      (reduce #'max elfs)
      (reduce #'+ (subseq (sort elfs #'>) 0 max-num)))))

(find-top-calories #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-1.txt" :max-num 3)
