#lang decaf



class PrintArgs {

  public static void main(String argv[])
  {
    int i = 0;
    while (i < argv.length) {
      IO.putString ("argv[");
      IO.putInt (i);
      IO.putString ("] = \"");
      IO.putString (argv[i]);
      IO.putString ("\"\n");
      i = i + 1;
    }
  }
}