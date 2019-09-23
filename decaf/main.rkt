#lang br/quicklang
(module reader br
  (require "reader.rkt")
  (provide read-syntax)
  
  (define (get-info port src-mod src-line src-col src-pos)
    (define (handle-query key default)
      (case key
        [(color-lexer)
           (dynamic-require 'decaf/colorer 'color-decaf)]
        #;[(drracket:indentation)
           (dynamic-require 'decaf/indenter 'indent-decaf)]
        #;[(drracket:toolbar-buttons)
           (dynamic-require 'decaf/buttons 'button-list)]
        [else default]))
    handle-query))