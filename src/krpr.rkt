#lang racket

(require "../faster-mk/mk.rkt")

(provide zipo
         assoco
         membero
         imapo
         mapo)

(define (zipo l1 l2 l)
  (conde
    [(== '() l1) (== '() l)]
    [(fresh (a1 a2 d1 d2 r)
       (== `(,a1 . ,d1) l1)
       (== `(,a2 . ,d2) l2)
       (== `((,a1 ,a2) . ,r) l)
       (zipo d1 d2 r))]))

(define (assoco x l p)
  (conde
    [(== '() l) (== #f p)]
    [(fresh (z v d)
       (== `((,z ,v) . ,d) l)
       (conde
         [(== z x) (== `(,z ,v) p)]
         [(=/= z x) (assoco x d p)]))]))

(define (membero x l)
  (fresh (a d)
    (== `(,a . ,d) l)
    (conde
      [(== x a)]
      [(=/= x a) (membero x d)])))

(define (imapo g l)
  (conde
    [(== '() l)]
    [(fresh (a d)
       (== `(,a . ,d) l)
       (g a)
       (imapo g d))]))

(define (mapo ge l v)
  (conde
    [(== '() l) (== '() v)]
    [(fresh (a d a-v d-v)
       (== `(,a . ,d) l)
       (== `(,a-v . ,d-v) v)
       (ge a a-v)
       (mapo ge d d-v))]))
