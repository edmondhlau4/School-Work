public class QueueTest{

  public static void main(String[] args){
    Queue q = new Queue();
    String str = new String("o shit waddup");
    String str1 = new String("dat boi");
    q.enqueue(str);
    q.enqueue(str1);

    //System.out.println(q.dequeue());
    q.dequeueAll();
    System.out.println(q);

  }
}
