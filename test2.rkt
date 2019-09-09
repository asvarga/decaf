#lang br/quicklang

(require brag/support)
(require decaf/tokenizer)

(apply-tokenizer-maker make-tokenizer #<<LABEL

// a line comment
break
abstract
byvalue
Break
_5key
ifelse
AAa /* comment */
aaA // break
/* this is a comment
   there is a // but it’s ignored */
char
0
123
0123
' '
'\n'
'x'
'\x'
'\\'
'\t'
//""
"\"hello\\"
"abcde"
"this is a test"
(>>= != >>>=)
(3)

LABEL
)