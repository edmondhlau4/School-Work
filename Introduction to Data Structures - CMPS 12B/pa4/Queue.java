// QueueInterface.java
public class Queue implements QueueInterface{


  private class Node{
    Object item;
    Node next;

    Node(Object item){
      this.item = item;
      next = null;
    }
  }

  private Node head;
  private Node tail;
  private int numItems;

  public Queue(){
    head = null;
    tail = null;
    numItems = 0;
  }


  // isEmpty()
  // pre: none
  // post: returns true if this Queue is empty, false otherwise public boolean isEmpty();
  public boolean isEmpty(){
    return (numItems == 0);
  }
  // length()
  // pre: none
  // post: returns the length of this Queue.
  public int length(){
    return numItems;
  }
  // enqueue()
  // adds newItem to back of this Queue
  // pre: none
  // post: !isEmpty()
  public void enqueue(Object newItem){
    Node N = new Node(newItem);
    if(numItems == 0){
      head = N;
      tail = head;
      numItems++;
    }
    else{
      if(numItems == 1){
        tail = N;
        head.next = tail;
        numItems++;
      }
      else{
        tail.next = N;
        tail = N;
        numItems++;
      }
    }
  }
  // dequeue()
  // deletes and returns item from front of this Queue // pre: !isEmpty()
  // post: this Queue will have one fewer element
  public Object dequeue() throws QueueEmptyException{
    if(numItems == 0){
      throw new QueueEmptyException("throwing QueueEmptyException");
    }
    else{
      if(numItems == 1){
        Node N = head;
        head = null;
        tail = null;
        numItems--;
        return N.item;
      }
      else{
          Node N = head;
          head = head.next;
          numItems--;
          return N.item;
        }
      }
    }

  // peek()
  // pre: !isEmpty()
  // post: returns item at front of Queue
  public Object peek() throws QueueEmptyException{
    Node N = head;
    return N.item;
  }
  // dequeueAll()
  // sets this Queue to the empty state
  // pre: !isEmpty()
  // post: isEmpty()
  public void dequeueAll() throws QueueEmptyException{
    head = null;
    tail = null;
    numItems = 0;
  }
  // toString()
  // overrides Object's toString() method
  public String toString(){
    Node N = head;
    StringBuffer str = new StringBuffer();
    for(; N!= null; N = N.next){
      str.append(N.item).append("\n");
    }
    return new String(str);
  }
}
