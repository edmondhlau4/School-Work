public class ListTest{
  public static void main(String[] args){
    List<Integer> list = new List<Integer>();
    List<Integer> A = new List<Integer>();
    System.out.println(list.isEmpty());
    list.add(1, 12);
    list.add(2, 23);
    System.out.println(list);
    list.add(3, 29);
    System.out.println(list.get(3));
    System.out.println(list.isEmpty());
    list.remove(2);
    System.out.println(list);
    System.out.println(list.equals(12));
    System.out.println("list.equals(A) is "+list.equals(A));


    }
}
