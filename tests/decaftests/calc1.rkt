#lang decaf


class Calculator
{
  static void main(String[] argv)
  {
    IntStack S = new IntStack(100);
    int sign = 1;

    char c = IO.getChar();
    while (true) {
      if (c == '+') {
	S.push(S.pop() + S.pop());
	c = IO.getChar();

      } else if (c == '-') {
	S.push(S.pop() - S.pop());
	c = IO.getChar();

      } else if (c == '*') {
	S.push(S.pop() * S.pop());
	c = IO.getChar();

      } else if (c == '/') {
	S.push(S.pop() / S.pop());
	c = IO.getChar();

      } else if (c == '\n' || c == -1) {
	IO.putInt(S.pop());
	IO.putString("\n");
	break;

      } else if (c == '~') {
	sign = sign * -1;
	c = IO.getChar();

      } else if (isDigit(c)) {
	int num = digitToInt(c);

	c = IO.getChar();
	while (isDigit(c)) {
	  num = 10 * num + digitToInt(c);
	  c = IO.getChar();
	}
	S.push(sign * num);
	sign = 1;

      } else if (c == ' ' || c == '\t') {
	 c = IO.getChar();

      } else {
	IO.putString("\nillegal character: '");
	IO.putChar(c);
	IO.putString("'\n");
	c = IO.getChar();
      }
    }
  }

  static boolean isDigit(char c)
  {
    return '0' <= c && c <= '9';
  }

  static int digitToInt(char c)
  {
    return c - '0';
  }


}




class IntStack {
  private int top;
  private int max;
  private int members[];

  public IntStack(int size)
  {
    max = size;
    top = -1;
    members = new int[max];
  }

  public int top()
  {
    if (top >= 0) return members[top];
    return -1;
  }

  public boolean isEmpty()
  {
    return top == -1;
  }

  public int pop()
  {
    int t = top();
    if (top >= 0) top = top - 1;
    return t;
  }

  public void push(int f)
  {
    if (top < max-1) {
      top = top + 1;
      members[top] = f;
    }
  }

  public boolean isFull()
  {
    return top >= max-1;
  }
}


