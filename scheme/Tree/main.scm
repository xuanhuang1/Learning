;; These make drracket treat this file as R5RS scheme:
#lang r5rs
(#%provide (all-defined))

(#%require "tree-test.scm")

(if (tree-test)
	(display "tree test looks good\n")
	(display "Rats! Something wrong somewhere in tree test\n"))
