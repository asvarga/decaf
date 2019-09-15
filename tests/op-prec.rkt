#lang decaf

{
  a * b + c = a - 2 == f = 4;             // test
  ((a * b) + c) = (((a - 2) == f) = 4);   // right  
}




/*

'(Start (DecafStart (Block "{" 

  (Statement (Expression 
    (Expression 
      (Expression 
        (Expression 
          (Expression 
            (Expression 
              (Expression (Primary "a")) 
              (BinaryOp "*") 
              (Expression (Primary "b"))
            ) 
            (BinaryOp "+") 
            (Expression (Primary "c"))
          ) 
          (BinaryOp "=") 
          (Expression (Primary "a"))
        ) 
        (BinaryOp "-") 
        (Expression (Primary (NonNewArrayExpr (Literal "2"))))
      ) 
      (BinaryOp "==") 
      (Expression (Primary "f"))
    ) 
    (BinaryOp "=") 
    (Expression 
      (Primary (NonNewArrayExpr (Literal "4")))
    )
  )";") 
  
  (Statement (Expression 
    (Expression (Primary (NonNewArrayExpr "(" 
      (Expression 
        (Expression (Primary (NonNewArrayExpr "(" 
          (Expression 
            (Expression (Primary "a")) 
            (BinaryOp "*") 
            (Expression (Primary "b"))
          ) 
        ")"))) 
        (BinaryOp "+") 
        (Expression (Primary "c"))
      ) 
    ")"))) 
    (BinaryOp "=") 
    (Expression (Primary (NonNewArrayExpr "(" 
      (Expression 
        (Expression (Primary (NonNewArrayExpr "(" 
          (Expression 
            (Expression (Primary (NonNewArrayExpr "(" 
              (Expression 
                (Expression (Primary "a")) 
                (BinaryOp "-") 
                (Expression (Primary (NonNewArrayExpr (Literal "2"))))
              ) 
            ")"))) 
            (BinaryOp "==") 
            (Expression (Primary "f"))
          ) 
        ")"))) 
        (BinaryOp "=") 
        (Expression (Primary (NonNewArrayExpr (Literal "4"))))
      ) 
    ")")))
  )";") 
  
"}")))

*/