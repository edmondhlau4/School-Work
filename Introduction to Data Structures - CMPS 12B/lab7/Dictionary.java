public class Dictionary implements DictionaryInterface{

  // private inner Node class
  private class Node{
    String key;
    String value;
    Node left;
    Node right;

    Node(String x, String y){
    key = x;
    value = y;
    Node left = null;
    Node right = null;
    }
  }


  // Fields for the IntegerList class
  private Node root;     // reference to first Node in List
  private int numPairs;  // number of items in this IntegerList

  // IntegerList()
  // constructor for the IntegerList class
  public Dictionary(){
     root = null;
     numPairs = 0;
  }

  // findKey()
  // returns a reference to the Node with argument 'key' in this Dictionary
  private Node findKey(Node R, String k){
    if(R == null || k.compareTo(R.key) == 0)
      return R;
    else if( k.compareTo(R.key) < 0)
      return findKey(R.left, k);
    else //k.compareTo(key) > 0
      return findKey(R.right, k);
  }

  // findParent()
  // returns the parent of N in the subtree rooted at R, or returns NULL
  // if N is equal to R. (pre: R != NULL)
  private Node findParent(Node N, Node R){
     Node P = null;
     if( N!=R ){
        P = R;
        while( P.left!=N && P.right!=N ){
           if(N.key.compareTo(P.key)<0)
              P = P.left;
           else
              P = P.right;
        }
     }
     return P;
  }

  // findLeftmost()
  // returns the leftmost Node in the subtree rooted at R, or NULL if R is NULL.
  Node findLeftmost(Node R){
    Node L = R;
    if( L!=null )
      for( ; L.left!=null; L=L.left);
    return L;
  }

  // printInOrder()
  // prints the (key, value) pairs belonging to the subtree rooted at R in order
  // of increasing keys to file pointed to by out.
  private void printInOrder( Node R){
    if( R!=null ){
      printInOrder(R.left);
      System.out.println(R.key+ " " + R.value);
      printInOrder( R.right);
    }
  }


  // deleteAll()
  // deletes all Nodes in the subtree rooted at N.
  private void deleteAll(Node N){
   if( N!=null ){
      deleteAll(N.left);
      deleteAll(N.right);
   }
}



  // isEmpty()
  // pre: none
  // returns true if this Dictionary is empty, false otherwise
  public boolean isEmpty(){
    if(numPairs == 0){
      return true;
    }
    else{
      return false;
    }
  }

  // size()
  // pre: none
  // returns the number of entries in this Dictionary
  public int size(){
    return numPairs;
  }

  // lookup()
  // pre: none
  // returns value associated key, or null reference if no such key exists
  public String lookup(String key){
    Node N = findKey(root, key);
    if(N==null){
      return null;
    }else{
      return N.value;
    }
  }

  // insert()
  // inserts new (key,value) pair into this Dictionary
  // pre: lookup(key)==null
  public void insert(String key, String value) throws DuplicateKeyException{
    Node N, A, B;
    if( findKey(root, key) != null ){
      throw new DuplicateKeyException ("Dictionary Error: calling insert() on NULL Dictionary reference\n");
    //  System.exit(1);
    }
    if(findKey(root, key) != null ){
      throw new DuplicateKeyException("Dictionary Error: cannot insert() on duplicate key\n");
    //  System.exit(1);
    }
    N = new Node(key, value);
    B = null;
    A = root;
    while( A != null ){
      B = A;
      if( key.compareTo(A.key)<0 ) A = A.left;
      else A = A.right;
    }
    if( B==null ) root = N;
    else if( key.compareTo(B.key)<0 ) B.left = N;
    else B.right = N;
    numPairs++;
  }

  // delete()
  // deletes pair with the given key
  // pre: lookup(key)!=null
  public void delete(String key) throws KeyNotFoundException{
    Node N, P, S;
    N = findKey(root, key);
  //System.out.println(N);
      if(N == null){
        throw new KeyNotFoundException("Dictionary Error: cannot delete() non-existent key");
        //System.exit(1);
      }
       if( N.left==null && N.right==null ){  // case 1
          if( N==root ){
             root = null;
          }else{
             P = findParent(N, root);
             if( P.right==N ) P.right = null;
             else P.left = null;
          }
       }else if( N.right==null ){  // case 2 (left but no right child)
          if( N==root ){
             root = N.left;
          }else{
             P = findParent(N, root);
             if( P.right==N ) P.right = N.left;
             else P.left = N.left;
          }
       }else if( N.left==null ){  // case 2 (right but no left child)
          if( N==root ){
             root = N.right;
          }else{
             P = findParent(N, root);
             if( P.right==N ) P.right = N.right;
             else P.left = N.right;
          }
       }else{                     // case3: N->left!=NULL && N->right!=NULL
          S = findLeftmost(N.right);
          N.key = S.key;
          N.value = S.value;
          P = findParent(S, N);
          if( P.right==S ) P.right = S.right;
          else P.left = S.right;
       }
       numPairs--;
    }



  // makeEmpty()
  // pre: none
  public void makeEmpty(){
    deleteAll(root);
    root = null;
    numPairs = 0;

  }

  // toString()
  // returns a String representation of this Dictionary
  // overrides Object's toString() method
  // pre: none
  public String toString(){
       printInOrder(root);
       return "";
  }
}
