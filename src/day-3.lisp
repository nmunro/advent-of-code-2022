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

(defun find-intersection (item1 item2 &key (remove-duplicates t))
  (if remove-duplicates
      (car (intersection (coerce item1 'list) (coerce item2 'list)))
      (intersection (coerce item1 'list) (coerce item2 'list))))

(defun find-priority (item)
  (1+ (position item +priority+ :test #'equal)))

(defun find-badge (item1 item2 item3)
  (let ((intersection-1 (find-intersection (coerce item1 'list) (coerce item2 'list) :remove-duplicates nil))
      (intersection-2 (find-intersection (coerce item2 'list) (coerce item3 'list) :remove-duplicates nil)))
    (car (intersection intersection-1 intersection-2))))

(defun part-1 (path)
  (let ((items (get-data path)))
    (loop :for item :in items :summing (find-priority (apply #'find-intersection (split-item item))))))

(defun part-2 (path)
  (let* ((batches (serapeum:batches (get-data path) 3)))
    (loop :for batch :in batches :summing (find-priority (apply #'find-badge batch)))))

(part-1 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-3.txt")
(part-2 #p"~/quicklisp/local-projects/advent-of-code-2022/data/data-day-3.txt")
