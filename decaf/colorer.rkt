#lang br

(require brag/support syntax-color/racket-lexer)
(require (rename-in br-parser-tools/lex-sre [- :-] [+ :+]))

(define decaf-lexer
  (lexer
   [(: "<" (* upper-case) ">")  
    (values lexeme 'parenthesis '|(| (pos lexeme-start) (pos lexeme-end))]
   [(: "</" (* upper-case) ">")  
    (values lexeme 'parenthesis '|)| (pos lexeme-start) (pos lexeme-end))]
   [(or (from/to "//" "\n") (from/to "/*" "*/"))
    (values lexeme 'comment #f (pos lexeme-start) (pos lexeme-end))]
   [(or (: "'" (:- any-char "\\" "\n" "'") "'")
        (: "'\\" (:- any-char "n" "t") "'")
        "'\\t'"
        "'\\n'") 
    (values lexeme 'string #f (pos lexeme-start) (pos lexeme-end))]
   [any-char (values #f #f #f #f #f)]))

(define (color-decaf port offset mode) 
  (define-values (str cat paren start end) (decaf-lexer port))
  (cond
    [(string? str)
     (values str cat paren start end 0 mode)]
    [else
      (define-values (str cat paren start end) (racket-lexer port))
      (values str cat paren start end 0 mode)]
  )
)

(provide color-decaf)