;; These make drracket treat this file as R5RS scheme:
#lang r5rs

(#%provide (all-defined))

(define (leaf a)
  (list a '()))

(define (empty-tree)
  (list))

(define (tree a a-list)
  (list a a-list))

(define (tree-value a-tree)
  (car a-tree))

(define (tree-children a-tree)
  (car (cdr a-tree)))


(define (tree-weight the-tree)
  (if (leaf? the-tree)
      1
      (begin
        (let* ((tmp-int 1) (tmp (tree-children the-tree)))
         (do ((i 0 (+ i 1)))
           ((= (length (tree-children the-tree)) i) tmp-int)
           (begin
             (set! tmp-int (+ (tree-weight (car tmp)) tmp-int))
             (set! tmp (cdr tmp)))
           )
          ))))

(define (ith-child the-tree index)
  (if (> index (- (tree-weight the-tree) 1))
      (display "not found ith item, index bigger than tree size!")
      (if (= index 0)
          (car the-tree)
          (begin
            (let* ((tmp-tree the-tree) (tmp (tree-children the-tree))(count 1))
              (do ((i 0 (+ i 1)))
                ((= (length (tree-children the-tree)) i) tmp-tree)
                (begin
                  (if (< i index)
                      (begin
                        (set! tmp-tree (ith-child (car tmp) (- index count)))
                        (set! count (+ count (tree-weight (car tmp))))
                        (set! tmp (cdr tmp)))
                      ))))))))

(define (tree-height the-tree)
  (if (eq? the-tree '())
      1
      (let* ((tmp-int 0) (tmp (tree-children the-tree)) (subheight 0))
        (do ((i 0 (+ i 1)))
          ((= (length (tree-children the-tree)) i) (+ 1 tmp-int))
          (begin
            (set! subheight (tree-height (car tmp)))
            (if (< tmp-int subheight)
                (set! tmp-int subheight)
                )
            (set! tmp (cdr tmp)))
          )
        )))

(define (tree? a-tree)
  (if (< (length a-tree) 2)
      (= 1 2)
      (= 1 1)))

(define (leaf? a-tree)
  (if (eq? (car(cdr a-tree)) '())
      (= 1 1)
      (= 1 2)))


;(define (tree-map (func s) a-tree)
;  (func a-tree)


(let ( (one  (leaf "one"))
	 (uni  (tree "uni" '()))  ; strange way to make a leaf, but o.k.
	 (solo (leaf "solo")) )
    (let ( (two ( tree "two" (list one uni solo)))
	   (bi  ( tree "bi" (list uni))) )
      (let ( (tri (tree "tri" (list two bi))) )
	(begin
         (ith-child two 4)
         ))))

