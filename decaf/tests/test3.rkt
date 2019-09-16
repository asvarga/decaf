#lang br/quicklang

(require brag/support)
(require decaf/tokenizer)

(apply-tokenizer-maker make-tokenizer #<<LABEL

{
  if C1 if C2 S1 else S2;
  if C1 { if C2 S2 else S2 };
}

LABEL
)