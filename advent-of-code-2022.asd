(defsystem "advent-of-code-2022"
  :version "0.0.1"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on (:split-sequence)
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "Generate a skeleton for modern project"
  :in-order-to ((test-op (test-op "advent-of-code-2022/tests"))))

(defsystem "advent-of-code-2022/tests"
  :author "nmunro"
  :license "BSD3-Clause"
  :depends-on ("advent-of-code-2022"
               :rove)
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for advent-of-code-2022"
  :perform (test-op (op c) (symbol-call :rove :run c)))
