#lang br/quicklang

(require brag/support)
(require decaf/tokenizer)

(apply-tokenizer-maker make-tokenizer #<<LABEL

// a line comment
class Adder {
  static public void main(String[] argv)
  {
    IO.putString ("enter two integers: ");
    int x = IO.getInt ();
    int y = IO.getInt ();

    IO.putInt (x);
    IO.putString (" + ");
    IO.putInt (y);
    IO.putString (" = ");
    IO.putInt (x+y);
    IO.putString ("\n");
  }
}

LABEL
)