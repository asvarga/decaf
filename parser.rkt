#lang brag

Start : DecafStart

DecafSubLang : DECAF-LANG-START-TOK DecafStart DECAF-LANG-END-TOK

DecafStart : Class+

Class : CLASS-TOK IDENTIFIER-TOK Super? OPEN-CURLY-TOK Member* CLOSE-CURLY-TOK
Super : EXTENDS-TOK IDENTIFIER-TOK
Member : Field | Method | Ctor
Field : Modifier* Type VarDeclaratorList SEMICOLON-TOK
Method : Modifier* Type IDENTIFIER-TOK FormalArgs Block
Ctor : Modifier* IDENTIFIER-TOK FormalArgs Block
Modifier : STATIC-TOK | PUBLIC-TOK | PRIVATE-TOK | PROTECTED-TOK
FormalArgs : OPEN-PAREN-TOK FormalArgList? CLOSE-PAREN-TOK
FormalArgList : FormalArg
              | FormalArg COMMA-TOK FormalArgList
FormalArg : Type VarDeclaratorId
Type : PRIM-TYPE-TOK
     | IDENTIFIER-TOK
     | Type OPEN-SQUARE-TOK CLOSE-SQUARE-TOK
VarDeclaratorList : VarDeclarator COMMA-TOK VarDeclaratorList
                  | VarDeclarator
VarDeclarator : VarDeclaratorId
              | VarDeclaratorId EQ-TOK Expression
VarDeclaratorId : IDENTIFIER-TOK
                | VarDeclaratorId OPEN-SQUARE-TOK CLOSE-SQUARE-TOK
Block : OPEN-CURLY-TOK Statement* CLOSE-CURLY-TOK
Statement : SEMICOLON-TOK
          | Type VarDeclaratorList SEMICOLON-TOK
          | IF-TOK OPEN-PAREN-TOK Expression CLOSE-PAREN-TOK Statement
          | IF-TOK OPEN-PAREN-TOK Expression CLOSE-PAREN-TOK Statement ELSE-TOK Statement
          | Expression SEMICOLON-TOK
          | WHILE-TOK OPEN-PAREN-TOK Expression CLOSE-PAREN-TOK Statement
          | RETURN-TOK Expression? SEMICOLON-TOK
          | CONTINUE-TOK SEMICOLON-TOK
          | BREAK-TOK SEMICOLON-TOK
          | SUPER-TOK ActualArgs SEMICOLON-TOK
          | Block
Expression : Expression BinaryOp Expression
           | UN-OP-TOKEN Expression
           | Primary
BinaryOp : BIN-OP-TOK | EQ-TOK
Primary : NewArrayExpr
        | NonNewArrayExpr
        | IDENTIFIER-TOK
NewArrayExpr : NEW-TOK IDENTIFIER-TOK Dimension+
             | NEW-TOK PRIM-TYPE-TOK Dimension+
Dimension : OPEN-SQUARE-TOK Expression CLOSE-SQUARE-TOK
NonNewArrayExpr : Literal
                | THIS-TOK
                | OPEN-PAREN-TOK Expression CLOSE-PAREN-TOK
                | NEW-TOK IDENTIFIER-TOK ActualArgs
                | IDENTIFIER-TOK ActualArgs
                | Primary PERIOD-TOK IDENTIFIER-TOK ActualArgs
                | SUPER-TOK PERIOD-TOK IDENTIFIER-TOK ActualArgs
                | ArrayExpr
                | FieldExpr
FieldExpr : Primary PERIOD-TOK IDENTIFIER-TOK
          | SUPER-TOK PERIOD-TOK IDENTIFIER-TOK
ArrayExpr : IDENTIFIER-TOK Dimension
          | NonNewArrayExpr Dimension
Literal : NULL-LIT-TOK | BOOLEAN-LIT-TOK | INT-LIT-TOK | CHAR-LIT-TOK | STRING-LIT-TOK
ActualArgs : OPEN-PAREN-TOK ExprList? CLOSE-PAREN-TOK
ExprList : Expression
         | Expression COMMA-TOK ExprList











