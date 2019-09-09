#lang br/quicklang
(require brag/support)
(require br-parser-tools/lex-sre)

;; see http://cs.brown.edu/courses/cs126/decaf-syntax.pdf

(define (make-tokenizer port)
  (define (next-token)
    (define decaf-lexer
      (lexer

       [nothing
        (token 'TEMPLATE-TOK lexeme)]

       ;; keywords
       [(or "break" "class" "continue" "else" "extends"
            "if" "new" "private" "protected" "public"
            "return" "static" "super" "this" "while")
        (token 'KEYWORD-TOK lexeme)]
       [(or "abstract" "byte" "case" "catch" "const"
            "default" "do" "double" "final" "finally"
            "for" "implements" "import" "instanceof" "interface"
            "long" "native" "goto" "package" "short"
            "switch" "synchronized" "throw" "throws" "transient"
            "try" "volatile")
        (token 'FORBIDDEN-TOK lexeme)]
       [(or "byvalue" "cast" "future" "generic" "inner"
            "none" "operator" "outer" "rest" "var")
        (token 'RESERVED-TOK lexeme)]

       ;; types
       [(or "boolean" "char" "int" "void")
        (token 'PRIM-TYPE-TOK lexeme)]
       [(or "byte" "double" "float" "long" "short")
        (token 'FORBIDDEN-TYPE-TOK lexeme)]

       ;; identifiers
       [(: (or "_" alphabetic) (* (or "_" alphabetic numeric)))
        (token 'IDENTIFIER-TOK lexeme)]

       ;; comments
       [(or (from/to "//" "\n") (from/to "/*" "*/"))
        (token 'COMMENT-TOK lexeme)]

       ;; literals
       [(or "0" (: (- numeric "0") (* numeric)))
        (token 'INT-LIT-TOK lexeme)]
       [nothing  ;; unimplemented
        (token 'FLOAT-LIT-TOK lexeme)]
       [(: "'" (- any-char "\\" "\n" "'") "'")
        (token 'CHAR-LIT-TOK (trim-ends "'" lexeme "'"))]
       [(: "'\\" (- any-char "n" "t") "'")
        (token 'CHAR-LIT-TOK (trim-ends "'\\" lexeme "'"))]
       ["'\\t'"
        (token 'CHAR-LIT-TOK "\t")]
       ["'\\n'"
        (token 'CHAR-LIT-TOK "\n")]
       [(: "\""
           (* (or (- any-char "\\" "\n" "\"")  ;; don't match single \
                  (: "\\" any-char)))          ;; \ captures next char
           "\"")
        (token 'STRING-LIT-TOK                 ;; clean using str-lexer
               (clean (trim-ends "\"" lexeme "\"")))]
       [(or "true" "false")
        (token 'BOOLEAN-LIT-TOK lexeme)]
       ["null"
        (token 'NULL-LIT-TOK lexeme)]

       ;; punctuation
       [(or "(" ")" "{" "}" "[" "]" ";" "," ".")
        (token 'PUNCTUATION-TOK lexeme)]

       ;; operators
       [(or "=" ">" "<" "!"
            "==" ">=" "<=" "!="
            "+" "-" "*" "/"
            "&&" "||" "%")
        (token 'OPERATOR-TOK lexeme)]
       [(or "~" "?" ":" "++" "--"
            "&" "|" "^" "<<" ">>" ">>>"
            "+=" "-=" "*=" "/=" "&=" "|="
            "^=" "%=" "<<=" ">>=" ">>>=")
        (token 'FORBIDDEN-OPERATOR-TOK lexeme)]

       ;; otherwise
       [whitespace (next-token)]
       [any-char (error (format "unexpected char: ~a" lexeme))]

       ))
    (decaf-lexer port)) 
  next-token)
(provide make-tokenizer)


(define (make-str-tokenizer port)
  (define (next-token)
    (define str-lexer
      (lexer
       [(- any-char "\\" "\n" "\"") lexeme]
       [(: "\\" (- any-char "n" "t")) (trim-ends "\\" lexeme "")]
       ["\\t" "\t"]
       ["\\n" "\n"]
       [any-char (error 'absurd)]  ;; unreachable when passed proper string contents
       )
      )
    (str-lexer port))
  next-token)

(define (lex-this lexer input) (lambda () (lexer input)))


(define (clean str)
  ;; TODO: find quicker way to build string from lexer
  (string-join (apply-tokenizer-maker make-str-tokenizer str) "")
  )
























