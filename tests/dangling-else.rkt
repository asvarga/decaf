#lang decaf

{
  if (C1)   if (C2) S1;   else S2;      // test
  if (C1) { if (C2) S2;   else S2; }    // right
  if (C1) { if (C2) S1; } else S2;      // wrong
}


/*

// with: DecafStart : Block

'(Start (DecafStart (Block "{" 

  // test
  (Statement "if" "(" (Expression (Primary "C1")) ")" 
    (Statement "if" "(" (Expression (Primary "C2")) ")" 
      (Statement (Expression (Primary "S1")) ";") 
    ) 
  "else" 
    (Statement (Expression (Primary "S2")) ";") 
  ) 
      
  // right
  (Statement "if" "(" (Expression (Primary "C1")) ")" (Statement (Block "{" 
    (Statement "if" "(" (Expression (Primary "C2")) ")" 
      (Statement (Expression (Primary "S2")) ";") 
    "else" 
      (Statement (Expression (Primary "S2")) ";")
    ) "}"
  ))) 
  
  // wrong
  (Statement "if" "(" (Expression (Primary "C1")) ")" (Statement (Block "{" 
    (Statement "if" "(" (Expression (Primary "C2")) ")" 
      (Statement (Expression (Primary "S1")) ";")
    ) "}"
  )) "else" 
    (Statement (Expression (Primary "S2")) ";")
  ) 
    
"}")))


*/