#lang brag
;decaf-program : (decaf-char | decaf-sexp)*
;decaf-char : CHAR-TOK
;decaf-sexp : SEXP-TOK

;Start : PUNCTUATION-TOK INT-LIT-TOK PUNCTUATION-TOK
Start : INT-LIT-TOK
