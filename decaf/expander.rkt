#lang br/quicklang
(require json)

(define-macro (decaf-mb PARSE-TREE)
  #'(#%module-begin
     'PARSE-TREE))
;     (define result-string PARSE-TREE)
;     (define validated-jsexpr (string->jsexpr result-string))
;     (display result-string)))
(provide (rename-out [decaf-mb #%module-begin]))

;(define-macro (decaf-char CHAR-TOK-VALUE)
;  #'CHAR-TOK-VALUE)
;(provide decaf-char)
;
;(define-macro (decaf-program SEXP-OR-JSON-STR ...)
;  #'(string-trim (string-append SEXP-OR-JSON-STR ...)))
;(provide decaf-program)
;
;(define-macro (decaf-sexp SEXP-STR)
;  (with-pattern ([SEXP-DATUM (format-datum '~a #'SEXP-STR)])
;    #'(jsexpr->string SEXP-DATUM)))
;(provide decaf-sexp)