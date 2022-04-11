public class DictionaryTest{

  public static void main(String[] args){
    Dictionary d = new Dictionary();
    d.insert("key1","value1");
    d.insert("key2", "value2");
    d.insert("key3", "value3");
    d.insert("key4", "value4");

    d.delete("key2");
    d.delete("key4");

    d.insert("key5", "value5");

//    d.makeEmpty();

//    System.out.println(d.isEmpty());


//    String str = d.toString();

//    System.out.println(str);

  }
}
