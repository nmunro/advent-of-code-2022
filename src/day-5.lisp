(defpackage advent-of-code-2022/day-5
  (:use :cl))

(in-package advent-of-code-2022/day-5)

(defun get-data (path)
  (with-open-file (in path :direction :input :if-does-not-exist nil)
    (loop :for line = (read-line in nil nil) :while line :collect line)))

(defun split-data (path)
  (let ((data (get-data path))
        (switch nil))
    (loop :for item :in data
          :when (string= item  "")
            :do (setf switch t)
          :end
          :if switch
            :collect item :into instructions
          :else
            :collect item :into layout
          :end
    :finally (return (list layout (cdr instructions))))))

(defun read-items (l)
  (loop :for x :from 0 :to (length l) :by 4
        :collect (string-trim " " (subseq l x (min (+ 4 x) (length l))))))

(defun structure-data (data)
  (let ((new-data (subseq data 0 (1- (length data)))))
    (loop :for item :in (loop :for d :in new-data :collect (read-items d))
          :collect (nth 0 item) :into l1
          :collect (nth 1 item) :into l2
          :collect (nth 2 item) :into l3
          :collect (nth 3 item) :into l4
          :collect (nth 4 item) :into l5
          :collect (nth 5 item) :into l6
          :collect (nth 6 item) :into l7
          :collect (nth 7 item) :into l8
          :collect (nth 8 item) :into l9
          :finally (return (list l1 l2 l3 l4 l5 l6 l7 l8 l9)))))

(defun remove-empty-strings (lists)
  (loop :for l :in lists :collect (remove "" l :test #'equal)))

(defun build-instruction-part-1 (instruction stacks)
  (let ((action (cdr (uiop:split-string instruction :separator " "))))
    (dotimes (x (parse-integer (car action)))
      (let ((from (1- (parse-integer (nth 2 action))))
            (to (1- (parse-integer (nth 4 action)))))
        (push (pop (nth from stacks)) (nth to stacks))))))

(defun build-instruction-part-2 (instruction stacks)
  (let* ((action (cdr (uiop:split-string instruction :separator " ")))
         (from (1- (parse-integer (nth 2 action))))
         (to (1- (parse-integer (nth 4 action))))
         (from (1- (parse-integer (nth 2 action))))
         (to (1- (parse-integer (nth 4 action))))
         (tmp '()))
    (dotimes (x (parse-integer (car action)))
      (push (pop (nth from stacks)) tmp))
    (setf (nth to stacks) (append (reverse tmp) (nth to stacks)))))

(defun part-1 (path)
  (let* ((data (split-data path))
         (model (remove-empty-strings (structure-data (car data))))
         (instructions (cadr data)))
  (dolist (instruction instructions)
      (build-instruction-part-1 instruction model))
    model))


(defun part-2 (path)
  (let* ((data (split-data path))
         (model (remove-empty-strings (structure-data (car data))))
         (instructions (cadr data)))
    (dolist (instruction instructions)
        (build-instruction-part-2 instruction model))
      model))

;; if one if fully contained in the other, not if they share some work
(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-5.txt")
(part-2 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-5.txt")
