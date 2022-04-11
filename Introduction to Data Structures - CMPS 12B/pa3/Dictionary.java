//-----------------------------------------------------------------------------
// DictionaryInterface.java
// interface for the Dictionary ADT
//-----------------------------------------------------------------------------

public class Dictionary implements DictionaryInterface{

  // private inner Node class
  private class Node{
    String key;
    String value;
    Node next;

    Node(String x, String y){
    key = x;
    value = y;
    next = null;
    }
  }


  // Fields for the IntegerList class
  private Node head;     // reference to first Node in List
  private int numItems;  // number of items in this IntegerList

  // IntegerList()
  // constructor for the IntegerList class
  public Dictionary(){
     head = null;
     numItems = 0;
  }

  // findKey()
  // returns a reference to the Node with argument 'key' in this Dictionary
  public Node findKey(String key){
     Node N = head;
     for(; N != null; N = N.next){
       if( key.equals(N.key)){
         return N;
       }
     }
     return null;
  }

  // isEmpty()
  // pre: none
  // returns true if this Dictionary is empty, false otherwise
  public boolean isEmpty()
  {
    boolean result = false;
    if (numItems == 0){
      result = true;
    }
    return result;
  }

  // size()
  // pre: none
  // returns the number of entries in this Dictionary
  public int size()
  {
    return numItems;
  }

  // lookup()
  // pre: none
  // returns value associated key, or null reference if no such key exists
  public String lookup(String key){
  //  Node N = findKey(key);
    Node N = head;
    for( ; N != null; N = N.next){
      if(N.key==key){
        return N.value;
      }
    }
    return null;
  }


  // insert()
  // inserts new (key,value) pair into this Dictionary
  // pre: lookup(key)==null
  public void insert(String key, String value) throws DuplicateKeyException{
  //  if(lookup(key) != null){
  //    throw new DuplicateKeyException("cannot insert duplicate keys");
  //  }
    if(numItems == 0){
      Node N = new Node(key, value);
      head = N;
      numItems++;
    }else{
      if(numItems == 1){
        Node N = new Node(key, value);
        head.next = N;
        numItems++;
      }else{
        Node N = head;
        while(N != null){
          if(N.next == null){
            break;
          }
          N = N.next;
        }
        N.next = new Node(key, value);
        numItems++;
      }
    }
  }

  // delete()
  // deletes pair with the given key
  // pre: lookup(key)!=null
  public void delete(String key) throws KeyNotFoundException{
    if(lookup(key) == null){
      throw new KeyNotFoundException("cannot delete non-existent key");
    }
    if(numItems == 1){
      head=null;
    }
    else{
      if(head.key.equals(key)){
      head = head.next;
      //N.next = null;
      }
      else{
        Node N = head;
        for( ; N != null; N = N.next){
          if(N.next == null){
            N = null;
            break;
          }
          else{
            if(N.next.key.equals(key)){
              Node P = N;
              Node C = P.next;
              P.next = C.next;
              C.next = null;
              break;
            }
          }
        }
      }
    }
    numItems--;
  }


  // makeEmpty()
  // pre: none
  public void makeEmpty(){
    numItems = 0;
    head = null;
  }

  // toString()
  // returns a String representation of this Dictionary
  // overrides Object's toString() method
  // pre: none
  public String toString(){
    Node N = head;
    StringBuffer str = new StringBuffer();
    for(; N!= null; N = N.next){
      str.append(N.key).append(" ").append(N.value).append("\n");
    }
    return new String( str);
  }

}
