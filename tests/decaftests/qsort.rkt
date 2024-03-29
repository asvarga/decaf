#lang decaf


class Node {
  public int data;
  public Node next;
  public Node(int a, Node n) {
    data = a;
    next = n;
  }
}


class MultipleNodes {
 public   Node high;
 public   Node equal;
 public   Node low;

 public MultipleNodes(Node h, Node e, Node l) {
   high = h;
   equal = e;
   low = l;
 }
}
 


class Main {
  
  public static Node Append(Node in, Node x) {
    if (in == null) 
      return x;
    in.next = Append(in.next, x);
    return in;
  }      

  public static MultipleNodes split3Ways(Node l, int pivot)
    {
      MultipleNodes result;   
      if (l == null)
	return new MultipleNodes(null, null, null);
      Node rst;
      Node curr;
      rst = l.next;
      curr = l;
      curr.next= null;

      result = split3Ways(rst, pivot);

      if (curr.data == pivot) 
	result.equal = Append(result.equal, curr);
      else if (curr.data < pivot)
	result.low = Append(result.low, curr);	
      else
	result.high = Append(result.high, curr);
      return result;
    }


  static Node qsort(Node list) {
    MultipleNodes result;
    if (list == null)
      return null;
    result = split3Ways(list, list.data);
    result.low = qsort(result.low);
    result.high = qsort(result.high);
    return Append(result.low, Append(result.equal, result.high));
  }
    
    static public void dump(Node n) {

     IO.putString("The list contains:\n");
     if (n == null) {
       IO.putString("Nothing\n");
       return;
     }
     else  {
       IO.putString("[");
     }
     while (true) {
       IO.putInt(n.data);
       n = n.next;
       if (n == null)  {
         IO.putString("]\n");
         return;
       }
       else
         IO.putString(", ");
      }
   }

  static void main(String[] argv) {
    Node L;
    L = null;

    int n = IO.getInt();
    while (n >= 0) {
      Node l = new Node(n, null);
      L = Append(L, l);
      n = IO.getInt();
    }

    IO.putString("Input data\n");
   dump(L);

    L = qsort(L);

    IO.putString("Output data\n");
    dump(L);
  }
}
      

 

