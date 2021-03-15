#lang racket

(require "../src/krpr.rkt"
         "../faster-mk/mk.rkt"
         rackunit)

(check-equal? (run 1 (x) (assoco 'x '((x 5) (y 2)) x)) '((x 5)))
(check-equal? (run 1 (x) (assoco 'y '((x 5) (y 2)) x)) '((y 2)))
(check-equal? (run 1 (x) (assoco 'z '((x 5) (y 2)) x)) '(#f))
(check-equal? (run 1 (x) (assoco 'is-even? '([is-even? (lambda (n)
                                                        (if (zero? n)
                                                          #t
                                                          (is-odd? (- n 1))))]
                                            [is-odd? (lambda (n)
                                                       (if (zero? n)
                                                         #f
                                                         (is-even? (- n 1))))])
                                 x))
              '((is-even? (lambda (n) (if (zero? n) #t (is-odd? (- n 1)))))))
(check-equal? (run 1 (x) (assoco 'factorial '([is-even? (lambda (n)
                                                        (if (zero? n)
                                                          #t
                                                          (is-odd? (- n 1))))]
                                            [is-odd? (lambda (n)
                                                       (if (zero? n)
                                                         #f
                                                         (is-even? (- n 1))))])
                                 x))
              '(#f))

; TODO : zipo, membero, imapo, mapo tests
