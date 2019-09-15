#lang br/quicklang
(require brag/support)
(require (rename-in br-parser-tools/lex-sre [- :-] [+ :+]))

;; see http://cs.brown.edu/courses/cs126/decaf-syntax.pdf

(define (make-tokenizer port)
  (port-count-lines! port) ; <- turn on line & column counting
  (define (next-token)
    (define decaf-lexer
      (lexer

       [nothing
        (token+ 'TEMPLATE-TOK "" lexeme "" lexeme-start lexeme-end)]

       ;; DECAF++
       [(: "<DECAF>")
        (token+ 'DECAF-LANG-START-TOK "<" lexeme ">" lexeme-start lexeme-end)]
       [(: "</DECAF>")
        (token+ 'DECAF-LANG-END-TOK "</" lexeme ">" lexeme-start lexeme-end)]
       [(: "<" (* upper-case) ">")
        (token+ 'LANG-START-TOK "<" lexeme ">" lexeme-start lexeme-end)]
       [(: "</" (* upper-case) ">")
        (token+ 'LANG-END-TOK "</" lexeme ">" lexeme-start lexeme-end)]

       ;; keywords
      ;  [(or "break" "class" "continue" "else" "extends"
      ;       "if" "new" "private" "protected" "public"
      ;       "return" "static" "super" "this" "while")
      ;   (token+ 'KEYWORD-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["break" (token+ 'BREAK-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["class" (token+ 'CLASS-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["continue" (token+ 'CONTINUE-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["else" (token+ 'ELSE-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["extends" (token+ 'EXTENDS-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["if" (token+ 'IF-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["new" (token+ 'NEW-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["private" (token+ 'PRIVATE-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["protected" (token+ 'PROTECTED-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["public" (token+ 'PUBLIC-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["return" (token+ 'RETURN-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["static" (token+ 'STATIC-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["super" (token+ 'SUPER-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["this" (token+ 'THIS-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["while" (token+ 'WHILE-TOK "" lexeme "" lexeme-start lexeme-end)]
       [(or "abstract" "byte" "case" "catch" "const"
            "default" "do" "double" "final" "finally"
            "for" "implements" "import" "instanceof" "interface"
            "long" "native" "goto" "package" "short"
            "switch" "synchronized" "throw" "throws" "transient"
            "try" "volatile")
        (token+ 'FORBIDDEN-TOK "" lexeme "" lexeme-start lexeme-end)]
       [(or "byvalue" "cast" "future" "generic" "inner"
            "none" "operator" "outer" "rest" "var")
        (token+ 'RESERVED-TOK "" lexeme "" lexeme-start lexeme-end)]

       ;; types
       [(or "boolean" "char" "int" "void")
        (token+ 'PRIM-TYPE-TOK "" lexeme "" lexeme-start lexeme-end)]
       [(or "byte" "double" "float" "long" "short")
        (token+ 'FORBIDDEN-TYPE-TOK "" lexeme "" lexeme-start lexeme-end)]

       ;; identifiers
       [(: (or "_" alphabetic) (* (or "_" alphabetic numeric)))
        (token+ 'IDENTIFIER-TOK "" lexeme "" lexeme-start lexeme-end)]

       ;; comments
       [(or (from/to "//" "\n") (from/to "/*" "*/"))
        ;;(token 'COMMENT-TOK lexeme #:skip? #t)]
        (next-token)]

       ;; literals
       [(or "0" (: (:- numeric "0") (* numeric)))
        (token+ 'INT-LIT-TOK "" lexeme "" lexeme-start lexeme-end)]
       [nothing  ;; unimplemented
        (token+ 'FLOAT-LIT-TOK "" lexeme "" lexeme-start lexeme-end)]
       [(: "'" (:- any-char "\\" "\n" "'") "'")
        (token+ 'CHAR-LIT-TOK "'" lexeme "'" lexeme-start lexeme-end)]
       [(: "'\\" (:- any-char "n" "t") "'")
        (token+ 'CHAR-LIT-TOK "'\\" lexeme "'" lexeme-start lexeme-end)]
       ["'\\t'"
        (token 'CHAR-LIT-TOK "\t")]
       ["'\\n'"
        (token 'CHAR-LIT-TOK "\n")]
       [(: "\""
           (* (or (:- any-char "\\" "\n" "\"")  ;; don't match single \
                  (: "\\" any-char)))          ;; \ captures next char
           "\"")
        (token 'STRING-LIT-TOK                 ;; clean using str-lexer
                (clean (trim-ends "\"" lexeme "\""))
                #:position (+ (pos lexeme-start) 1)
                #:line (line lexeme-start)
                #:column (+ (col lexeme-start) 1)
                #:span (- (pos lexeme-end)
                          (pos lexeme-start) 2))]
       [(or "true" "false")
        (token+ 'BOOLEAN-LIT-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["null"
        (token+ 'NULL-LIT-TOK "" lexeme "" lexeme-start lexeme-end)]

       ;; punctuation
       ["(" (token+ 'OPEN-PAREN-TOK "" lexeme "" lexeme-start lexeme-end)]
       [")" (token+ 'CLOSE-PAREN-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["{" (token+ 'OPEN-CURLY-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["}" (token+ 'PUNCTUATION-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["[" (token+ 'OPEN-SQUARE-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["]" (token+ 'PUNCTUATION-TOK "" lexeme "" lexeme-start lexeme-end)]
       [";" (token+ 'SEMICOLON-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["," (token+ 'COMMA-TOK "" lexeme "" lexeme-start lexeme-end)]
       ["." (token+ 'PERIOD-TOK "" lexeme "" lexeme-start lexeme-end)]

       ;; operators
       [(or "=" "||" "&&" "==" "!=" "<" ">" "<=" ">=" "+" "-" "*" "/" "%")
        (token+ 'BIN-OPERATOR-TOK "" lexeme "" lexeme-start lexeme-end)]
       [(or "+" "-" "!")
        (token+ 'UN-OPERATOR-TOK "" lexeme "" lexeme-start lexeme-end)]
       [(or "~" "?" ":" "++" ":-"
            "&" "|" "^" "<<" ">>" ">>>"
            "+=" "-=" "*=" "/=" "&=" "|="
            "^=" "%=" "<<=" ">>=" ">>>=")
        (token+ 'FORBIDDEN-OPERATOR-TOK "" lexeme "" lexeme-start lexeme-end)]

       ;; otherwise
       [whitespace (next-token)]
       [any-char (error (format "unexpected char: ~a" lexeme))]

       ))
    (decaf-lexer port)) 
  next-token)
(provide make-tokenizer)


(define str-lexer
  (lexer
   [(:- any-char "\\" "\n" "\"") lexeme]
   [(: "\\" (:- any-char "n" "t")) (trim-ends "\\" lexeme "")]
   ["\\t" "\t"]
   ["\\n" "\n"]
   [any-char (error 'absurd)]  ;; unreachable when passed proper string contents
   )
  )
(define (clean str)
  (string-join (apply-lexer str-lexer str) "")
  )

(define (token+ type left lex right lex-start lex-end)
  (let ([l0 (string-length left)] [l1 (string-length right)])
    (token type (trim-ends left lex right)
           #:position (+ (pos lex-start) l0)
           #:line (line lex-start)
           #:column (+ (col lex-start) l0)
           #:span (- (pos lex-end)
                     (pos lex-start) l0 l1))
    )
  )






















