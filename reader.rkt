#lang br/quicklang
(require "tokenizer.rkt" "parser.rkt")

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  ;(define parse-tree (make-tokenizer port))
  (define module-datum `(module decaf-module decaf/expander
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)